From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Mon, 21 Sep 2015 17:08:49 +0000
Message-ID: <1442855328.29498.30.camel@transmode.se>
References: <1440157010.1759.83.camel@transmode.se>
	 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
	 <1442245035.10125.18.camel@transmode.se>
	 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
	 <1442508864.21964.26.camel@transmode.se>
	 <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
	 <xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "gitster@pobox.com" <gitster@pobox.com>,
	"pclouds@gmail.com" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 21 19:08:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ze4aH-00041j-C7
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 19:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933168AbbIURIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 13:08:54 -0400
Received: from smtp.transmode.se ([31.15.61.139]:59954 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933094AbbIURIw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2015 13:08:52 -0400
Received: from exch1.transmode.se (exch1.transmode.se [192.168.201.16])
	by smtp.transmode.se (Postfix) with ESMTP id C17C711870E6;
	Mon, 21 Sep 2015 19:08:49 +0200 (CEST)
Received: from exch1.transmode.se (192.168.201.16) by exch1.transmode.se
 (192.168.201.16) with Microsoft SMTP Server (TLS) id 15.0.1076.9; Mon, 21 Sep
 2015 19:08:49 +0200
Received: from exch1.transmode.se ([fe80::3029:ce14:7d42:cc5]) by
 exch1.transmode.se ([fe80::3029:ce14:7d42:cc5%17]) with mapi id
 15.00.1076.000; Mon, 21 Sep 2015 19:08:49 +0200
Thread-Topic: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Thread-Index: AQHQ9I1i4MUVkjVcJE+EJNOGRY0lNp5HFboA
In-Reply-To: <xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.16.5 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.200.4]
Content-ID: <83C2557A0275CC45935E2583BE63E67D@transmode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278311>

On Mon, 2015-09-21 at 09:48 -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Is it really necessary to remove write access in $GIT_DIR? Do we (git
> > devs) have some guidelines about things in $GIT_DIR?
> 
> Those who are allowed to "git push" into it should be able to write
> there.  It is a different matter that "git" program itself may make
> a policy decision to disallow some operations that the filesystem
> bits alone would have allowed (e.g. you can arrange the "pusher" to
> only come over the wire via "receive-pack" and "receive-pack" may
> deliberately lack support for writing into $GIT_DIR/config).
> 

I view $GIT_DIR similar to "/" and "/tmp". Normally one does not let normal users write to "/"
as you want to keep this level clean. It is not obvious to everybody what files are important
under $GIT_DIR when mixed with tmp files etc.
$GIT_DIR/tmp would solve this nicely.

 Jocke