From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones
 fail
Date: Tue, 17 Nov 2015 22:00:18 +0100
Message-ID: <564B9562.3050801@web.de>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
 <20151113053547.GD29708@sigill.intra.peff.net>
 <CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
 <CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
 <20151113233807.GD16173@sigill.intra.peff.net>
 <20151113234116.GA18234@sigill.intra.peff.net>
 <CAGZ79kaUZ08GXZjKtYNmRYOCQ0EQpsGd8+6PYFDU1LxYLw818g@mail.gmail.com>
 <564A279C.6000802@web.de>
 <CAGZ79kbh_8oBRnQAmDzh3LANS6iGXNjLkYMLfuk9iysXghHQXg@mail.gmail.com>
 <564A4DB1.4070507@web.de>
 <CAGZ79kZhn59GTs9LRnAoPrSwf43jjgi0_qWibrQ8gCvjas_MKA@mail.gmail.com>
 <564B8406.9070706@web.de>
 <CAGZ79kZGdOCzJ5V-RZcBbZE09HsSUQrypHaFT-N8wks7NA=21Q@mail.gmail.com>
 <564B9091.7070902@web.de>
 <CAGZ79kaiWSyXUG_mgUcqt6Mpuj_1EhNOTyG-7NL=28vvi770jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 22:00:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZynMs-0005zE-NQ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 22:00:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbbKQVAm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 16:00:42 -0500
Received: from mout.web.de ([212.227.15.4]:54781 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753789AbbKQVAl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 16:00:41 -0500
Received: from [192.168.178.41] ([79.211.115.166]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LlWVj-1aY7yl026B-00bJ2B; Tue, 17 Nov 2015 22:00:20
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kaiWSyXUG_mgUcqt6Mpuj_1EhNOTyG-7NL=28vvi770jA@mail.gmail.com>
X-Provags-ID: V03:K0:TNdyTDq/MkKo2xmmOsj4pPomRKQ2VBGSwIYhh0T6Ff9R+y6MOB4
 2crH9pyAF+c0jTSGt0bi1yl9T6hLnDoHGjLwJhYZVcdb5N5ze14NHA30CGMB4YkoM6aIhtH
 IZEdz4yE0w6Kdh1u52lzGZeGu/CbITWMp+Ki+Il03iJiC03GCFEZ4Wy40eCFgARhdITy6ph
 doHna4URFKGDAio0D2ZBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bQeY/J9uJpw=://WDx+0V7kBMIck9w5NxsA
 ZUa2y3QR/5hli70g1c6/HaFA/fRHqFn2/renhRbqsLwP/VsiLg+IiQ2jLGqdYi89Mn22QYXvP
 LhWoGZVa8ivwWa88gg2VGNPdM760WYZ1BH18J2vM5VwNb0vY1i3SWyKUj2CHLYb4dDwWhdTh4
 /6u7KZl5TjSAer5hl4ecJskXGupACAs9Dwk8lfDWjzGS5WfDyNWSn6N5PKNnDgPqSJ6ajb4AT
 yK1FW+na+rx6AhrwTKV8zWpzYRezulpQRwDZ2Ofej5NGGsxySq/e5v+V9ApCTUEKs2GmA0+gj
 Ydymaa8Qh2We4qoivL0c2G7ShjwNb7hjVQxigKkLJofZfYntHw/f0u+/2HEYFeAhftnDgNRYd
 n/quRVWTnZ1rKwOXAxciCZfqsdNbTi8h1YOXwnG3FK+R0LjIcY1TY5syVOL7eVA73VpmAJhnz
 e1hJqZu/SLZ9/did4XVtlTDz+dJFUGXqIk8H6ShQL1WjYl5rw+jP9Z9XsfJ/0fajVLIMwGvD4
 C+xfGcI+kMdoaDyvrmEL354HTNn5m6fiezeZ4iV1mKPrCnUqWTl+nlbr/JZ5NqNPtCAjbp8jo
 zA0wKoXlhQoZQHX52MMZ6llehvvmB0lmxEB2daQ65YPWA/kIE4KuhELa0gI4cpBna2iih8CKW
 VSrvOV6MAnxi4bzTWtmnoL68J5z9GQwRKxZJycFxIPxFDjpx8DDqxbEivfZ/7OuN50G7wsL/d
 tzTDUIEbERscm6LQWDZld3VM0/atuO+/YRZsxbr9nClDx/VlznawRbeQIjiLgZ4WQUXEkAAi 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281419>

Am 17.11.2015 um 21:49 schrieb Stefan Beller:
> I assumed we'd have yet another flag to activate the new behavior,
> but if you want to roll out that new feature as a default, I agree on
> needing the fallback.

Ah, I was under the impression that users are surprised by --depth
not propagating into the submodules, so I considered this a bugfix
which doesn't need extra configuration (and the subject line seems
to support my impression ;-).

And if some users really need the old behavior, they can remove the
--recurse-submodules from the clone and issue a submodule update
afterwards (Unless they speak up now and tell us why having --depth
only apply to the superproject is a feature ... ;-).
