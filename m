From: Julio Lajara <ju2wheels@gmail.com>
Subject: Re: Potential bug in gitweb 1.7.2
Date: Mon, 26 Jul 2010 09:52:42 -0400
Message-ID: <4C4D932A.1010101@gmail.com>
References: <4C4D152A.7050505@gmail.com>	<alpine.DEB.2.00.1007260508290.14251@dr-wily.mit.edu>	<4C4D8940.80802@gmail.com>	<201007261536.11688.jnareb@gmail.com> <AANLkTinAO8R6mg967XeqFgMHInT4pMlxODz29Jovfki1@mail.gmail.com>
Reply-To: julio.lajara@alum.rpi.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Anders Kaseorg <andersk@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 15:52:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdO6v-0008Su-LX
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 15:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab0GZNws convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 09:52:48 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58080 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0GZNwr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 09:52:47 -0400
Received: by yxg6 with SMTP id 6so70941yxg.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 06:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=FjoZ3Qz7t10Z7SjRvaOSCnUJFJcq8QCi5hYDfeMa6XA=;
        b=gE7cwOZL2GRRTt/xHu9kZ2EkfVybHLAXHnWqDLyian0QZ460NG7KHFcbJwIzU7ecot
         zVcj0MguioFXaw/MgjND9pPU+wH8VETZn5QwjBBPQ3zPZr7XTSyhePnDpa/UaCmIwZca
         K2e4m/bDr62otEEvzCGob+Zohe0e1qcaD6toE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=npAwpy3jdbPu+fPzKkTxpLUQbeDlM22gtwPp4BFql3qlkDe692P+pRhuGM6zGqRvTq
         MhkM8mY3C9A2hfljEt18h1fndskdD1MKG1EfPQGb0DSC2QMAc3G3Sogq2pul0LzRO63z
         BoXP+0P6YDeTCPrKeBr5CzIYba3KxrK044BV0=
Received: by 10.150.73.37 with SMTP id v37mr4060726yba.311.1280152366151;
        Mon, 26 Jul 2010 06:52:46 -0700 (PDT)
Received: from [192.168.1.100] (c-76-28-16-43.hsd1.ct.comcast.net [76.28.16.43])
        by mx.google.com with ESMTPS id g31sm3713537ibh.4.2010.07.26.06.52.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 06:52:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.10) Gecko/20100527 Thunderbird/3.0.5
In-Reply-To: <AANLkTinAO8R6mg967XeqFgMHInT4pMlxODz29Jovfki1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151838>

Hi, Ive managed to narrow down the issue to a line in the gitolite's=20
contrib/gitweb/gitweb.conf that I appended to the default=20
/etc/gitweb.conf . It was working with 1.7.0.4 but 1.7.2 doesnt like=20
this line:

$ENV{GL_USER} =3D $cgi->remote_user || "gitweb";

I corrected it by just setting it equal to gitweb and all is well now.

Thanks,

On 07/26/2010 09:39 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Jul 26, 2010 at 13:36, Jakub Narebski<jnareb@gmail.com>  wrot=
e:
>   =20
>> On Mon, 26 Jul 2010, Julio Lajara wrote:
>>
>>     =20
>>> Hi Anders, thanks for the input. I will begin chasing down the issu=
e in
>>> my config then, but its strange that it would stop working as the e=
xact
>>> same configuration works without issue in 1.7.0.4 . Ill follow up w=
ith
>>> what I find.
>>>
>>> On 07/26/2010 05:27 AM, Anders Kaseorg wrote:
>>>       =20
>>     =20
>>>> The error that Julio originally posted:
>>>>
>>>>
>>>>         =20
>>>>>> [Sat Jul 24 23:11:41 2010] [error] [client 192.168.1.100] Can't =
call
>>>>>> method "http" on an undefined value at /usr/share/gitweb/index.c=
gi
>>>>>> line 3401., referer: http://192.168.1.142/gitweb/
>>>>>>             =20
>>>> looks very strange, and does not seem like it would result from ju=
st a
>>>> packaging problem.
>>>>         =20
>> Julio, could you show us the neigbourhood of line 3401 in your index=
=2Ecgi
>> file?  What is this index.cgi file - git doesn't have it?
>>     =20
> His index.cgi is just gitweb.cgi under a different name. Line 3401 is
> the same as gitweb/gitweb.cgi in the 1.7.2 release.
>   =20
