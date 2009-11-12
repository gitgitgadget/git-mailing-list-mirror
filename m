From: Eugene Sajine <euguess@gmail.com>
Subject: Re: get git not to care about permissions
Date: Thu, 12 Nov 2009 10:28:57 -0500
Message-ID: <76c5b8580911120728j2f9995basb554b0a493a364bf@mail.gmail.com>
References: <26268938.post@talk.nabble.com>
	 <76c5b8580911111327k43daece9s2e71d0a2b8adcebd@mail.gmail.com>
	 <76c5b8580911111334p76232995qbd6bf6b06d250854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: sconeman <schoen@bu.edu>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:29:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8bbh-0004jT-Je
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752930AbZKLP2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 10:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbZKLP2x
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:28:53 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:49870 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816AbZKLP2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 10:28:52 -0500
Received: by iwn8 with SMTP id 8so1823986iwn.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 07:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=g958nzyYZvAXQY9mCEemxeC6l3sNtFzW6LExZXMXAfA=;
        b=YdWVNld1oLJFWvXrw1KoUCu13iM9pcUE0QmjETv8aSGXcmnkMvcfmKYXm0muys/EyR
         djWN0ViXQOkbnPxmrY7jaebcWwzLoF1zx81hRO79hz6gLbeoHMRqFp330+MG4LzB9SEE
         SHujTWaHQJAGcJWr40mDeheHCTf3HFDC0VC4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xLZ0RMoSPM+YsR/YhuyBYqWmuDBAVHdM5YDrG2qzlWkawqk7MqpIFhc8kh4sp9xrH1
         bmpOwLfv01kK55HiBPbXufXtr2nhDF2L9T+gdhfb+nCgvf24nltuvotJkX/cbgGuFHPt
         YM0MP0lG4yrSrhZ+K7cPwb0j1ve7dAp21s97A=
Received: by 10.231.168.131 with SMTP id u3mr385503iby.26.1258039737651; Thu, 
	12 Nov 2009 07:28:57 -0800 (PST)
In-Reply-To: <76c5b8580911111334p76232995qbd6bf6b06d250854@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132775>

>>
>> On Nov 9, 2009 11:06 AM, "sconeman" <schoen@bu.edu> wrote:
>>
>>
>> Hello,
>>
>> I'm trying to set up git on a NetApp drive at my school, BU. =C2=A0T=
he NetApp
>> shares are configured with Windows permissions, and I forget the spe=
cifics
>> (which I can figure out if needed) about why this is the case, but b=
asically
>> the deal is that if true UNIX permissions were to be used, Windows w=
ouldn't
>> be able to read the drive. =C2=A0As such, and because we use the Ker=
beros
>> ticketing system, the permissions for the drive are set up such that=
 the
>> owners (myself and my team members) have full permissions, but nobod=
y else
>> does. =C2=A0Git doesn't like this and won't even create a bare repos=
itory. =C2=A0Is
>> there any way I can get git to ignore permissions and just do what i=
t needs
>> to do?
>>
>> Thanks in advance for the help!
>>
>> -Matt
> --
On Wed, Nov 11, 2009 at 4:34 PM, Eugene Sajine <euguess@gmail.com> wrot=
e:
> Hi,
>
> I had almost similar issue - bare repos in my case should be set up u=
nder
> user which only few guys are having password from. So what I did is j=
ust a
> small program which creates the bare repo locally and makes secure co=
py to
> this user home. All authentication is hidden from the end user. Then =
users
> can access their repos via git protocol. Ialso fillthe repo with some
> additional info for cgit.
>
> Eugene

BTW I'm using "git clone --bare" in this process, so if you have a
repo with working copy you can create a bare one separately, put it on
the server and then connect to it via "git remote add"

Eugene
