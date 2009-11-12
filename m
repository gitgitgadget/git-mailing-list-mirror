From: Matt Schoen <mtschoen@gmail.com>
Subject: Re: get git not to care about permissions
Date: Thu, 12 Nov 2009 10:47:30 -0500
Message-ID: <3cf217d80911120747k116d3747g75dc60f17e00127@mail.gmail.com>
References: <26268938.post@talk.nabble.com>
	 <76c5b8580911111327k43daece9s2e71d0a2b8adcebd@mail.gmail.com>
	 <76c5b8580911111334p76232995qbd6bf6b06d250854@mail.gmail.com>
	 <76c5b8580911120728j2f9995basb554b0a493a364bf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 16:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8btZ-00068G-UU
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 16:47:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195AbZKLPr0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 10:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZKLPr0
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 10:47:26 -0500
Received: from mail-yw0-f202.google.com ([209.85.211.202]:63260 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZKLPrZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 10:47:25 -0500
Received: by ywh40 with SMTP id 40so385005ywh.33
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O4VnIBtG+ySns/wXBl66U1CH81VkPxs61y38CxEn/EI=;
        b=sL8rySfnNSIS/f3l1vJXC46D/pL5s6oooJ6xrNwCLMPUnN1t4UyKQulAbHJrgHu8lt
         HKqZB2uMDm3M85ACk4dlhlJVvCRoLZzd4eJa4I0MVdXbNqfsXfA3On77+3E9NCjKeuP6
         szW8a7mh7iHUrJopUxQt++8YOnZUxGN2aOGXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HKz40zmYaEUW8FPSawYcnYzQoYcfNTVHbAS674/VGKsBsI1Eeje4cVEOr6KyNO/UhE
         /oMnKSCVyf5g+VZn1eC8WdJgWjCgIuXHIlkI8KQ2cYFfnyAhhrJSQYeEvFUabT5NSt6i
         aweEwPO2+aGi9vKrXzEtr+REOLjPuHVsM6g48=
Received: by 10.101.3.1 with SMTP id f1mr2856546ani.85.1258040850385; Thu, 12 
	Nov 2009 07:47:30 -0800 (PST)
In-Reply-To: <76c5b8580911120728j2f9995basb554b0a493a364bf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132777>

Thanks for the tip, Eugene, but I'm not sure if this helps me.

I'm trying to set up the repo on a shared directory, which isn't
actually on a physical computer (NetApp is basically a
data-server-in-a-box, and as such I do not directly interface with
it).  Thus, I must access the directory over the school network, which
uses Kerberos security.  I think it is this restriction that is giving
git its issues.

On Thu, Nov 12, 2009 at 10:28 AM, Eugene Sajine <euguess@gmail.com> wro=
te:
>>>
>>> On Nov 9, 2009 11:06 AM, "sconeman" <schoen@bu.edu> wrote:
>>>
>>>
>>> Hello,
>>>
>>> I'm trying to set up git on a NetApp drive at my school, BU. =A0The=
 NetApp
>>> shares are configured with Windows permissions, and I forget the sp=
ecifics
>>> (which I can figure out if needed) about why this is the case, but =
basically
>>> the deal is that if true UNIX permissions were to be used, Windows =
wouldn't
>>> be able to read the drive. =A0As such, and because we use the Kerbe=
ros
>>> ticketing system, the permissions for the drive are set up such tha=
t the
>>> owners (myself and my team members) have full permissions, but nobo=
dy else
>>> does. =A0Git doesn't like this and won't even create a bare reposit=
ory. =A0Is
>>> there any way I can get git to ignore permissions and just do what =
it needs
>>> to do?
>>>
>>> Thanks in advance for the help!
>>>
>>> -Matt
>> --
> On Wed, Nov 11, 2009 at 4:34 PM, Eugene Sajine <euguess@gmail.com> wr=
ote:
>> Hi,
>>
>> I had almost similar issue - bare repos in my case should be set up =
under
>> user which only few guys are having password from. So what I did is =
just a
>> small program which creates the bare repo locally and makes secure c=
opy to
>> this user home. All authentication is hidden from the end user. Then=
 users
>> can access their repos via git protocol. Ialso fillthe repo with som=
e
>> additional info for cgit.
>>
>> Eugene
>
> BTW I'm using "git clone --bare" in this process, so if you have a
> repo with working copy you can create a bare one separately, put it o=
n
> the server and then connect to it via "git remote add"
>
> Eugene
>
>
