From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] string_list: Add STRING_LIST_INIT macro and make use
 of it.
Date: Sat, 10 Jul 2010 17:41:44 -0500
Message-ID: <20100710224144.GA3951@burratino>
References: <20100702202257.GA7539@burratino>
 <546093148a7ccecace6552c75a70a1cd66b3f420.1278272508.git.tfransosi@gmail.com>
 <20100707151956.GA1529@burratino>
 <AANLkTimWpEmaLrRK0YoM2BA7_VU3FIsKr3uq0utd5n6q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, srabbelier@gmail.com, gitster@pobox.com,
	raa.lkml@gmail.com, peter.kjellerstedt@axis.com
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 11 00:42:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXikm-0000Dx-SN
	for gcvg-git-2@lo.gmane.org; Sun, 11 Jul 2010 00:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366Ab0GJWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 18:42:31 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63177 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180Ab0GJWma (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 18:42:30 -0400
Received: by iwn7 with SMTP id 7so3434714iwn.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 15:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IsRmL7heEpb+HSdxPsHd4x8LFCEABaWvOCLMU0eA2IM=;
        b=U8w/TlMf3rlpaLUSX/rBkG5z5v2P2sQH0AJV+6OJcNDyhbK41o4KnRFVT7BwVKDHtl
         5Jm5ya6kj978/Ny4N6kivef5WpY4owNeIolVRLHaPj9nleDujymiWE7tqnMItGoqAcMY
         fken9wL4XtCNeBqnHUqXhhZ0jecJTJnCXD14s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XDuFN0AH1zTawoaffGrBeQB94uaFUAtRSfHTTU9JTeAAdxKKBMcJI+hCV+3YjOtnPV
         DPOeqsrnuRHRWdatTz9Pws89J9kQRKX5ZSuYI7B8pFTvOUwejfY4W3dczL0P5WWSslKV
         UdKNSGo8kGWe5peu3/CYEGD8Relr3PURdAC8w=
Received: by 10.231.12.76 with SMTP id w12mr11657757ibw.87.1278801749666;
        Sat, 10 Jul 2010 15:42:29 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id e8sm11316495ibb.2.2010.07.10.15.42.28
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 15:42:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimWpEmaLrRK0YoM2BA7_VU3FIsKr3uq0utd5n6q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150735>

Thiago Farina wrote:
> On Wed, Jul 7, 2010 at 12:19 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> | $ git log --oneline --author=Thiago origin/pu
>> | 183113a string_list: Add STRING_LIST_INIT macro and make use of it.
>> | [...]
>> | $ git branch tf/string-list-init 183113a
>
> How did you figure out the part "tf/string-list-init"?

I made it up.  Actually, I used

  git log --ancestry-path 183113a..origin/pu

for some unrelated purpose and remembered the name Junio used, but the
name is completely unimportant; my local branch can be named
tf/string-list-macro and it would still work.  Or I can use no local
branch at all, like this:

  git branch -r --contains 183113a

I am guessing you tried the equivalent of

  git branch -r --contains 0afcb5f7

which asks git a different question.
