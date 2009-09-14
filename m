From: Marius Storm-Olsen <marius@storm-olsen.com>
Subject: Re: [PATCH 14/17] Add ftruncate implementation for MSVC
Date: Mon, 14 Sep 2009 21:03:05 +0200
Message-ID: <4AAE9369.8030007@gmail.com>
References: <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com>	 <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com>	 <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com>	 <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com>	 <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstormo@gmail.com>	 <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com>	 <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com>	 <cover.1252925290.git.mstormo@gmail.com>	 <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com>	 <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com> <81b0412b0909140718i7d2c4e3cpc96477f8374d80b4@mail.gma
 il.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:03:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnGpP-0008OB-S9
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 21:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbZINTC6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 15:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756796AbZINTC6
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 15:02:58 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:63961 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756795AbZINTC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 15:02:58 -0400
Received: by ewy2 with SMTP id 2so963865ewy.17
        for <git@vger.kernel.org>; Mon, 14 Sep 2009 12:03:00 -0700 (PDT)
Received: by 10.211.141.15 with SMTP id t15mr7311842ebn.59.1252954978876;
        Mon, 14 Sep 2009 12:02:58 -0700 (PDT)
Received: from ?192.168.0.196? (cm-84.215.55.206.getinternet.no [84.215.55.206])
        by mx.google.com with ESMTPS id 28sm3661574eyg.4.2009.09.14.12.02.57
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Sep 2009 12:02:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <81b0412b0909140718i7d2c4e3cpc96477f8374d80b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128489>

Alex Riesen said the following on 14.09.2009 16:18:
> On Mon, Sep 14, 2009 at 15:11, Marius Storm-Olsen <mstormo@gmail.com>=
 wrote:
>> +int ftruncate(int fd, __int64 length)
>> +{
>> +       HANDLE fh =3D (HANDLE)_get_osfhandle(fd);
>> +       if (!fh || _lseeki64(fd, length, SEEK_SET))
>=20
> According to MSDN, error is manifested by returning INVALID_HANDLE_VA=
LUE (=E2=80=931):

You're absolutely right. I was too deep in Posix-land when writing this=
=2E
Updated patch will follow tomorrow.

--
=2Emarius
