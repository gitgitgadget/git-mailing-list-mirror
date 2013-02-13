From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC v2] git-multimail: a replacement for post-receive-email
Date: Wed, 13 Feb 2013 15:26:57 +0000
Message-ID: <201302131526.57342.andyparkins@gmail.com>
References: <5104E738.602@alum.mit.edu> <vpqtxpgb6ue.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	=?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	Chris Hiestand <chiestand@salk.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 13 16:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5eF7-0005QA-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 16:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934109Ab3BMP1F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 10:27:05 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60211 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758942Ab3BMP1D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 10:27:03 -0500
Received: by mail-wi0-f174.google.com with SMTP id hi8so5849259wib.1
        for <git@vger.kernel.org>; Wed, 13 Feb 2013 07:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=7hpLzOB+y1suyhmA+1JjG3canVxa5qG9OmeZMMxD3ps=;
        b=Qyyms13L2RACU6ahHv2Qu8sbqd/3YxtalN3TYcTtDk+89SMG7l0HS0S8mG6jZtpxfS
         aWWn4rczYmU7WE+QkKQ3TN/nled0p6NLsuAMcPSCTZTyrsxcDlEFciQbU3MsNFTUed9J
         y9k9W9rQqTl0yHOQ3WpaLJphIFOUQfobtw49VMA4mmSSPfTEP5vB/xIb2TJieua6fwCA
         Fa8oSbWmVAe6/eH7Hu0WS2FskCbcBKtkhaR1mf3ivcA0uTxxZOzv/0JO8/K3Ve1lGdr3
         wMc5kV9ayhEFAiFsV4Xtf9TQLwQGwD935lmpKv8B3EWpE0SAFkF0T6A1B6XFqaQTu4OP
         vKYw==
X-Received: by 10.194.108.101 with SMTP id hj5mr38902505wjb.6.1360769220236;
        Wed, 13 Feb 2013 07:27:00 -0800 (PST)
Received: from momentum.localnet ([91.84.15.31])
        by mx.google.com with ESMTPS id ek4sm8514312wib.11.2013.02.13.07.26.57
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Feb 2013 07:26:59 -0800 (PST)
User-Agent: KMail/1.13.7 (Linux/3.2.0-3-686-pae; KDE/4.8.4; i686; ; )
In-Reply-To: <vpqtxpgb6ue.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216260>

On Wednesday 13 February 2013 14:56:25 Matthieu Moy wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:

> I think adding a short "dependencies" section in the README (or in an
> INSTALL file) saying which Python version works could save new users the
> trouble (I see the sheebang inside the scripts says python2 but since I
> couldn't use my system's python and called
> "path/to/python git_multimail.py", this didn't help). Making the script
> portable with python 2 and 3 would be awesome ;-).

For my 2p worth, I don't like seeing hooks called like this.  Particular those 
that come as part of the standard installation.

I call mine by installing little scripts like this (on Debian):

  #!/bin/sh
  # stored as $GIT_WORK_DIR/.git/hooks/post-receive-email
  exec /bin/sh /usr/share/git-core/contrib/hooks/post-receive-email

This means I don't have to make the sample script executable, it gets upgraded 
automatically as git gets upgraded, and the interpreter is easily changed by 
changing a file in my work directory, rather than altering a packaged file.

I'd prefer to see the /usr/share/git-core/templates/hooks/ using a similar 
technique, as to my mind, installing a full copy of the sample script in every 
new repository is wasteful and leaves you with potentially out-of-date scripts 
when you update git.


Andy

-- 
Dr Andy Parkins
andyparkins@gmail.com
