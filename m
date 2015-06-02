From: Junio C Hamano <gitster@pobox.com>
Subject: Re: AW: Getting the full path of a conflicting file within a custom merge driver?
Date: Tue, 02 Jun 2015 10:47:35 -0700
Message-ID: <xmqq4mmq3sug.fsf@gitster.dls.corp.google.com>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	<xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek\, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Tue Jun 02 19:47:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzqHw-0007ab-CO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 19:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbbFBRrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 13:47:39 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36252 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbbFBRrh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 13:47:37 -0400
Received: by ieclw1 with SMTP id lw1so43636442iec.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sgV24+5NZV/EbeN0kTTpqdva4lnx7p4eJ0zuLsszhDw=;
        b=jmtRaVB69Rp1GLn3cA5CbQX5+WhtQ6obE0q4Yf+hAXgwAloP+N1kixjJRPBZxVZCj+
         Do6SSHw9e9KybXLS+mdfL5P33GtmkYPOd5XVYYavzbj867bPFu/P6i2z1hkh4JI2Yi6Q
         qty8GnqZYoOZhUD26rM7dzGow/yM1kXtlVITHD4XtqwypawhAzDffGLSHd5EqxwqMfxv
         iEUzXWanbKD6aeajmZXC0cHJJNIJcZNYCgYOfHSnAaNSetqMumtrd5NV97kcn8N82fJu
         7DCEZFWMxbwzfCVTt7YwJer7rN1OtQcvprT6gOtnQDk93iQxmf7VskcDG3aqeBdEuI34
         kGCw==
X-Received: by 10.107.18.222 with SMTP id 91mr33939669ios.34.1433267256689;
        Tue, 02 Jun 2015 10:47:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id x4sm12939266iod.26.2015.06.02.10.47.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 10:47:36 -0700 (PDT)
In-Reply-To: <D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
	(Andreas Gondek's message of "Tue, 2 Jun 2015 10:57:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270572>

"Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:

> thank you for responding this fast. I would suggest providing this
> information as an additional parameter (like %A %O %B and %L) maybe
> %P.

Yes, per-cent plus a letter is more in line with the way information
is passed to the scripts already.  Thanks for making a more sensible
counter-suggestion.  And your %P(ath) sounds like a sensible choice.

It won't be a two-liner, though, as the path is an arbitrary string,
unlike the names of the three temporary files, and needs to be
quoted for the shell.

Let me see if I can find time today to cook up something.
