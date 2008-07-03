From: "Dana How" <danahow@gmail.com>
Subject: Re: ':/<oneline prefix>' notation doesn't support full file syntax
Date: Thu, 3 Jul 2008 11:27:01 -0700
Message-ID: <56b7f5510807031127j10e33f3bl516180f7a9b5b5db@mail.gmail.com>
References: <279b37b20807022242q69ad2fcbwb8c11a9d6165272d@mail.gmail.com>
	 <7vfxqr2won.fsf@gitster.siamese.dyndns.org>
	 <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, danahow@gmail.com
To: "Eric Raible" <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 20:28:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KETXM-0007NL-RA
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 20:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753459AbYGCS1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 14:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753433AbYGCS1I
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 14:27:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:47305 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416AbYGCS1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 14:27:05 -0400
Received: by ug-out-1314.google.com with SMTP id h2so719208ugf.16
        for <git@vger.kernel.org>; Thu, 03 Jul 2008 11:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aq0f53+aetTDUREvk931ZdKLJIDCflSUmrjSK6jFNDI=;
        b=wiPd75pgdBJ6ubmDrqsvt9nUsjT+Ioz6NscN0IreoIF0S4UYW56YUirTJPX7gYv9sa
         BCxc2Y7iZyouH1weAEnjJ0kLzw/wN3d0TdURORDtYnMyHsftC/Oshz9JUuBeJnBskcpl
         x61CS+cHmzn0ZrVx1ACZM8rliFUUAhxoCGBuI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wLOcOOBd8oXradD7L/TZ4IwjXQZDUKXMN9ec2yNFUFFelLXh+dfF7L4XZxvoxyXp9V
         ZHoFzm+aKCSeZx4zR0DwGG/pVqRHa1NBVYFYWW8blA/tnGSnUkppd11Hx8FNUg0/RCt1
         qKubNA8hOELldK7eIJHFUCY1IOj2roIcxV2xw=
Received: by 10.78.197.9 with SMTP id u9mr159415huf.111.1215109621496;
        Thu, 03 Jul 2008 11:27:01 -0700 (PDT)
Received: by 10.78.130.7 with HTTP; Thu, 3 Jul 2008 11:27:01 -0700 (PDT)
In-Reply-To: <279b37b20807030150t2e9cbcc8wf099a5872568af8@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87302>

On Thu, Jul 3, 2008 at 1:50 AM, Eric Raible <raible@gmail.com> wrote:
> On Thu, Jul 3, 2008 at 1:34 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> "Eric Raible" <raible@gmail.com> writes:
>>
>> Is there anything to fix?  In that example, you are looking for a commit
>> that talks about "object name:sha1_name.c" in the comment.
>
> Yes.  What if I'm looking for specific file (i.e. sha1_name.c) in the commit
> described by ":/object name:", just like I can do with 28a4d9404:sha1_name.c?
>
> This is not ambiguous if we first consider the entire string as the prefix.
> If that fails we look for a filename after the final ':'.

In part you are proposing this because it is a consistent extension.
But a problem with the current :/string is that it adds 2nd meanings
to both : and / ,
which is not all that consistent to start with.

Last year Junio proposed that :/ be changed to ?
to eliminate the overloading;  thus your proposal becomes:
  ?string:filename
He chose ? because it results in a search backwards through commits.
(You could make that ?string?:filename if you prefer,  where the 2nd ?
 is only needed if you include a filename.)

I was surprised to see Dscho advocating removing this feature altogether.
Others proposed other command sequences which avoided :/ .
If :/ is now going to be extended and thus perhaps more likely to
appear in scripts,
is now the time to change it to ? which has no other special meaning to git?

Thanks,
-- 
Dana L. How danahow@gmail.com +1 650 804 5991 cell
