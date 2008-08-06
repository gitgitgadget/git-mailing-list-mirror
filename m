From: Pascal Obry <pascal@obry.net>
Subject: Re: something fishy with Git commit and log from file
Date: Wed, 06 Aug 2008 18:28:09 +0200
Organization: Home - http://www.obry.net
Message-ID: <4899D119.1080403@obry.net>
References: <48997D2E.9030708@obry.net> <20080806104432.GG7121@bit.office.eurotux.com> <4899848C.6030800@obry.net> <7v3alirw6b.fsf@gitster.siamese.dyndns.org>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luciano Rocha <luciano@eurotux.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 18:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQltD-0006qV-Ct
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 18:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbYHFQ22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Aug 2008 12:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYHFQ22
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 12:28:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:14659 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbYHFQ21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 12:28:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so17679fgg.17
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 09:28:25 -0700 (PDT)
Received: by 10.86.23.17 with SMTP id 17mr939206fgw.32.1218040105544;
        Wed, 06 Aug 2008 09:28:25 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.201.122])
        by mx.google.com with ESMTPS id l19sm3442136fgb.7.2008.08.06.09.28.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 06 Aug 2008 09:28:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
In-Reply-To: <7v3alirw6b.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91526>

Junio C Hamano a =E9crit :
> Pascal Obry <pascal@obry.net> writes:
>=20
>> So definitely a Git bug! Can be reproduced with:
>>
>>    $ mkdir repo && cd repo
>>    $ git init
>>    $ mkdir dir
>>    $ cd dir
>>    $ echo file > file
>>    $ echo log > log
>>    $ git add file
>>    $ git commit --file=3Dlog
>>    fatal: could not read log file 'log': No such file or directory
>=20
> Try it without cding down to "dir".

Yes it works. It also works if I do:

     $ echo log > ../log

instead of

     $ echo log > log

Git is looking for the log file at the Git root.

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
