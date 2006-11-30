X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Stephan Feder <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 15:00:17 +0100
Message-ID: <456EE3F1.5070101@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281629.08636.andyparkins@gmail.com> <456EC738.6000103@b-i-t.de> <200611301255.41733.andyparkins@gmail.com>
Reply-To: sf@b-i-t.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 30 Nov 2006 14:00:43 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <200611301255.41733.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32746>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpmSk-0003ho-3G for gcvg-git@gmane.org; Thu, 30 Nov
 2006 15:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936397AbWK3OA1 convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006 09:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936411AbWK3OA1
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 09:00:27 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:62429 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S936397AbWK3OA0
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006
 09:00:26 -0500
Received: (qmail 2862 invoked by uid 1011); 30 Nov 2006 14:00:24 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.25563 secs); 30 Nov 2006 14:00:24 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 30 Nov 2006 14:00:24
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id 2754725537; Thu, 30 Nov 2006 15:00:19
 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Thursday 2006 November 30 11:57, sf wrote:
>=20
>> > Worse, if you allow that to happen, the supermodule can commit a s=
tate
>> > that cannot be retrieved from the submodule's repository.  The ONL=
Y thing
>> > a supermodule can record about a submodule is a commit.
>>
>> So what? You have a submodule commit that only exists in the
>> supermodule. I fail to see the problem. The changes you made to the
>> submodule _in the supermodule_ can later be pulled from wherever you=
 want.
>=20
> Eh?  The files aren't stored in the supermodule, they're stored in th=
e=20
> submodule.  The ONLY thing in the supermodule is the commit hash.  Th=
e=20
> objects for the submodule are still /in/ the submodule.

But you have got the submodule on your local disk anyway. So just setup=
=20
alternates and the supermodule contains all of the submodule.

> It sounds like you're suggesting that the supermodule commit includes=
 files=20
> from the submodule?  How can that work?   The two aren't separate ent=
ities=20
> then, it's just one big repository.=20

It works as it always works in git: The supermodule commit contains the=
=20
submodule commit, the submodule commit contains the submodule files, so=
=20
the supermodule contains the submodule (at least the part of the=20
submodule that is visible). It _must_ be one repository but it need not=
=20
be big (once more, use alternates).

> I mean, what would this supermodule commit look like?  Would it inclu=
de a=20
> commit message?  Which module should that commit message be about?  S=
hould=20
> the commit's parents be stored?  Which parents, the submodule HEAD or=
 the=20
> supermodule HEAD?  Which tree object should it link to?  The one in t=
he=20
> submodule doesn't exist, so it'll have to be a freshly made up one fo=
r the=20
> supermodule - except now you've put submodule paths in the supermodul=
e. =20
> Nope.  That's never going to work.

Again I do not see the problem. Probably I have a much simpler picture=20
of submodules: They are just commits in the supermodule's tree.=20
Everything else follows naturally from how git currently behaves.

Of course it works. It is simple, it is the git way.

Am I missing the point?

Regards

Stephan

--=20
b.i.t.
beratungsgesellschaft f=FCr informations-technologie mbh
Stephan Feder
elisabethenstr. 62   fon: +49(0)6151/827575
64283 darmstadt      fax: +49(0)6151/827576
mailto:sf@b-i-t.de   www: http://www.b-i-t.de
