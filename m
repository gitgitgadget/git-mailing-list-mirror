From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] pretend_sha1_file(): Change return type from int to void
Date: Tue, 06 Oct 2015 16:30:36 +0200
Organization: gmx
Message-ID: <ef5b20ed42ea20b2891fc3998a81f339@dscho.org>
References: <1444133704-29571-1-git-send-email-tklauser@distanz.ch>
 <632cbcf1dc9fa45ce71693a2cfae73e4@dscho.org>
 <20151006135101.GA11304@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tobias Klauser <tklauser@distanz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 06 16:30:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjTGT-0007Kb-1m
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 16:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbbJFOao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 10:30:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:61570 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752227AbbJFOal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 10:30:41 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MDhny-1ZqdD11ycY-00H4ER; Tue, 06 Oct 2015 16:30:37
 +0200
In-Reply-To: <20151006135101.GA11304@distanz.ch>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:iDfK1C11B+C0f0USm99UVIV/2bo2bFibbL+1voeB2UWtrFLxi78
 Vmb7DSbSvEhprYWU1oycpD1n3Bc5kE8/F+ucxSzYruQafc1Us7V84vEQyzC2IBqWEMfgG/x
 Bd1lGE0hK64cXS8sR0vqlGk5CBrugUEm/IeCiucRv4cY7yCMqIx1W4UigAL4R6HlWKhglnX
 tgQMby40uQrKwZfk2cXhQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:k0+TB90/lxs=:bZ2PAQqflebhkY437OLBOf
 i30Zvs0KAVFqNu1gmwo5mn++Qlf8ynCNDpHzqG231+YBIA0d14+MDdOZgDCANFZyGUS0tLo6/
 2FPB8pqNLfsGys/3epIAWTMbF6Lzmbn5KHmO4zDJXgw/nRynKSG0iCt647fEdupji15aJvdts
 WKykMxCzt85KME/CExoN3nVR0umorZpQY37YMBn88ysFtbFj3t9W8FAPaeoip/DFrU1v5Qv08
 c7zn89+gXa99UtJ6ZtOUu6Q097MjNcNJlihkRMq2NcmnPBXMpUM/5Y3ziSN+Qapbq/Qk68OOO
 mZ+4JiDKk6WpINlOmNpn3aSv38S1V8ZGI2xES6UU4fXiklSRlXcsJzZJxwZdREwHfP11FO7pA
 6qAxCR6l+opFEY9fMDlKPB5wERBuLfc8kt0uwGA7phNFgocn1yJ89OMtiSD/s9h4TD1IvW0Iu
 KdbeWmBYTFbZtlWac+EExDPg9eONS6hboAxCZ3v27OBdAep8w8n0BQEKoE0GzzIyK+UmpyQ8W
 j0YWWNImIDVX+bDaGsBjg90fpbOGNGfQfhulnENWK4J6OZE3xBcplivN4AGWHpFJsCscIc5pj
 7b8x2K5ebrTb51gW9Kd4QLx+ACf5I9ES5EzBcj95gh56IJTf7y3h5ctQkHAy8iag+O4v/CUtn
 DdPJZEb8T0Pe0la9uDMpr6t2OzsjyKElv7Kpx4NmVtDsjvyX1AQ+gGZa4K8WgaNDPD8Z3kf1X
 RcTtT70HO7fI4H8jEadDQiysiFxXm5pG9D4seqGHHQDYswhwxqIjipp8KMUSYDqXQLv8dIuM 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279150>

Hi Tobias,

On 2015-10-06 15:51, Tobias Klauser wrote:

> On 2015-10-06 at 15:16:12 +0200, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>>
>> On 2015-10-06 14:15, Tobias Klauser wrote:
>> > prented_sha1_file() always returns 0 and its only callsite in
>> > builtin/blame.c doesn't use the return value, so change the return type
>> > to void.
>>
>> While this commit message is technically correct, it would appear that there are some things left unsaid.
>>
>> Is there a problem with the current code that is solved by not returning 0? If so, could you add it to the commit message? And in particular, change the oneline appropriately?
> 
> There's no problem with the current code other than that the return
> value is unused and thus unnecessary for correct funcionality. So it's
> certainly not a functional problem but rather a cosmetic change.

Okay.

> Does such a change even make sense (it's one of my first patch to git,
> so I'm not really sure what your criteria in this respect are)?

Welcome!

As to the patch, I cannot speak for Junio, of course, but my preference would be to keep the return type. Traditionally, functions that can fail either die() or return an int; non-zero indicates an error. In this case, it seems that we do not have any condition (yet...) under which an error could occur. It does not seem very unlikely that we may eventually have such conditions, though, hence my preference.

Ciao,
Johannes
