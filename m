From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use
 of it.
Date: Fri, 2 Jul 2010 14:30:02 -0500
Message-ID: <20100702193002.GB6585@burratino>
References: <7vbpawifwa.fsf@alter.siamese.dyndns.org>
 <bcb1b64b5db55dd11a398da3cf2c95145852ddfb.1278097858.git.tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlwb-0002xm-1m
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759546Ab0GBTac convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 15:30:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:38119 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756411Ab0GBTab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:30:31 -0400
Received: by iwn7 with SMTP id 7so3572890iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 12:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ES2/OZ/FolSmzsNXUSUzXtEFD1zM5MW7o4EG+kXkuaw=;
        b=CCwgiyujhac+QkOcZRT2VuiG/SPAasmwDHjrDTqbK/lKbhAxhS4IXmIQ5f9LYAtelK
         O1iAhJNkZk2tAsRV3ZBwo+dZ0oDSrLO5xpL6lZj3zpoV/6bdj4yTcvZDpL6VGHtRqSdh
         NeodVpW+yIDDdbrz/9Bux3iYzw7o9oqFy7g7Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Zm2Tgd7EHrR1qhh8TRKRv9srDyaAFevvnD+MxlqCRbQFHakjwq37zsmFDLWLQD0qqJ
         Hy0XKk5LMQxijTcz5TWo2pnJi1bI4q5SlaOO74+NHrw04MyLu6juX9xRiipl7cIFpwXx
         ofOa6WMEnUfBeC7j7935uU0E90V/n6rt0fUf4=
Received: by 10.231.183.19 with SMTP id ce19mr1329429ibb.35.1278099030426;
        Fri, 02 Jul 2010 12:30:30 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 34sm4360821ibi.12.2010.07.02.12.30.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 12:30:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <bcb1b64b5db55dd11a398da3cf2c95145852ddfb.1278097858.git.tfransosi@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150158>

Thiago Farina wrote:

> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Um, I am not so fond of this one.

The argument to STRING_LIST_INIT is hard to interpret without
familiarity.  What did you think of Peter=E2=80=99s suggestion to use a=
n a
different macro for the strdup_strings case?  Something like
STRING_LIST_INIT_DUP_ON_APPEND, but perhaps shorter.

It would also be nice to update
Documentation/technical/api-string-list.txt with whatever you choose.=20

That said, I do like the goal of making it easier to reorganize
struct string_list later if needed.
