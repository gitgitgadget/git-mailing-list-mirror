From: Thomas Anderson <zelnaga@gmail.com>
Subject: Re: moving a remote branch?
Date: Thu, 17 Jun 2010 08:55:38 -0500
Message-ID: <AANLkTikbOLRc6BvXtO8vznFevj0V_iZr34U1QaHCfFBh@mail.gmail.com>
References: <AANLkTikA5jGl1LiU2sNTN1NP_syTfPAeLF7sS6dBozyN@mail.gmail.com>
	<AANLkTimTSU7Db7cMlC0ZxQ47IoBUr4Ee4G-GfgDoYLmK@mail.gmail.com>
	<A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nazri Ramliy <ayiehere@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 15:56:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPFa7-00077S-1a
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 15:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760056Ab0FQN42 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jun 2010 09:56:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42114 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759762Ab0FQN41 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 09:56:27 -0400
Received: by pwi1 with SMTP id 1so4283448pwi.19
        for <git@vger.kernel.org>; Thu, 17 Jun 2010 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VYBihIpzBA7C5wmt5CxC10vG4fZCs7tyaXEGcI1j4nY=;
        b=Tq0S/F1Avsd6ORuwZ/Qg3INJnjFdseTElwp2GOn6GMVtxiXhlW4WqAn5CWzw4CQaL7
         vyIgrXsdKWam9ktEKrF8J06kPtWRXu6Fkng+XHCb81NqqFmqJdRfeKWU0ALtqJFuw4uL
         tlfSJDxAlhv3FF3sgeNdbHoiZRnl47w9KslQY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZNatGRV8cPrSj+vASyAjby8Lamm+UHQJviMVYTvreKr1hG2IUKWZr+zODgkxTlJYzU
         8FUA/4TpQPHjYBHqpfsMw0CxQgDYvstlXk7p16/RafDYGxbK5N7Dy6eVgMMKkTQpwlmd
         VpkFVIuZshkc5UWvk4Q+skJi6Cpq//QG3HJQ8=
Received: by 10.142.8.13 with SMTP id 13mr95903wfh.210.1276782938098; Thu, 17 
	Jun 2010 06:55:38 -0700 (PDT)
Received: by 10.142.87.4 with HTTP; Thu, 17 Jun 2010 06:55:38 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483CEEA82@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149308>

Do I need to switch to the local featurea branch before doing "git
push origin origin/featurea:refs/heads/featureb" or can I do that
while in the default branch?

On Thu, Jun 17, 2010 at 3:28 AM, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
>> -----Original Message-----
>> From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] O=
n
>> Behalf Of Nazri Ramliy
>> Sent: den 17 juni 2010 08:20
>> To: Thomas Anderson
>> Cc: git@vger.kernel.org
>> Subject: Re: moving a remote branch?
>>
>> On Thu, Jun 17, 2010 at 12:35 PM, Thomas Anderson <zelnaga@gmail.com=
>
>> wrote:
>> > git branch -m origin/zelnaga/featurea origin/zelnaga/featureb does=
n't
>> > seem to be working for me. =A0Instead, I get this error:l
>> >
>> > error: refname refs/heads/origin/zelnaga/featurea
>> > fatal: Branch rename failed
>> >
>> > Any ideas?
>>
>> The error =A0message could be improved here.
>>
>> The reason you get the error is because you were asking git
>> to rename a "remote" branch, which it refuses to do because,
>> well, it's a remote branch, and for all practical purposes git
>> won't allow you to modify any "remote" stuff as they are all
>> read-only from our point of view.
>>
>> If you run "git remote -v" you'll most likely see that "origin"
>> is listed in the output which means that your "origin/zelnaga/featur=
ea"
>> is a remote branch because its name begin with "origin/".
>>
>> Hope this helps.
>>
>> nazri.
>
> Renaming a remote branch is a two step operation. First you push the
> old branch into its new name, and then you remove the old branch. It
> can be done with these commands:
>
> =A0 =A0 =A0 =A0git push origin origin/featurea:refs/heads/featureb
> =A0 =A0 =A0 =A0git push origin :featurea
>
> //Peter
>
>
