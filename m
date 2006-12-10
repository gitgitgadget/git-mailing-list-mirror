X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Sun, 10 Dec 2006 12:46:51 -0500
Message-ID: <28E2300C-8F7A-406F-8FDA-F8786AE95B40@mac.com>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 10 Dec 2006 17:47:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-10_01:2006-12-08,2006-12-08,2006-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0611300000 definitions=main-0612100007
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33908>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtSlb-0006qN-KI for gcvg-git@gmane.org; Sun, 10 Dec
 2006 18:47:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762287AbWLJRrI convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006 12:47:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762288AbWLJRrI
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 12:47:08 -0500
Received: from smtpout.mac.com ([17.250.248.177]:63389 "EHLO smtpout.mac.com"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762287AbWLJRrH
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006
 12:47:07 -0500
Received: from mac.com (smtpin01-en2 [10.13.10.146]) by smtpout.mac.com
 (Xserve/8.12.11/smtpout07/MantshX 4.0) with ESMTP id kBAHkxON019290; Sun, 10
 Dec 2006 09:46:59 -0800 (PST)
Received: from [10.0.7.253] (hc6524e82.dhcp.vt.edu [198.82.78.130])
 (authenticated bits=0) by mac.com (Xserve/smtpin01/MantshX 4.0) with ESMTP id
 kBAHksrJ009486 (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
 Sun, 10 Dec 2006 09:46:56 -0800 (PST)
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>, Jeff Garzik
 <jeff@garzik.org>
Sender: git-owner@vger.kernel.org

> On 12/10/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>> I've recently become somewhat interested in the idea of using GIT =20
>> to store the contents of various folders in /etc.  However after a =20
>> bit of playing with this, I discovered that GIT doesn't actually =20
>> preserve all permission bits since that would cause problems with =20
>> the more traditional software development model.  I'm curious if =20
>> anyone has done this before; and if so, how they went about =20
>> handling the permissions and ownership issues.
>>
>> I spent a little time looking over how GIT stores and compares =20
>> permission bits; trying to figure out if it's possible to patch in =20
>> a new configuration variable or two; say "preserve_all_perms" and =20
>> "preserve_owner", or maybe even "save_acls".  It looks like =20
>> standard permission preservation is fairly basic; you would just =20
>> need to patch a few routines which alter the permissions read in =20
>> from disk or compare them with ones from the database.  On the =20
>> other hand, it would appear that preserving ownership or full =20
>> POSIX ACLs might be a bit of a challenge.

On Dec 10, 2006, at 10:06:14, Santi B=E9jar wrote:
> I have not used it, but you could try:
>
> http://www.isisetup.ch/
>
> that uses git as a backend.

Wow, umm, that's actually really interesting for me, given that I'm =20
most interested in these sorts of things on Debian.  I can't find =20
much documentation on their site; the tools look vaguely immature but =20
I haven't really had much time to look at it yet.

On Dec 10, 2006, at 09:49:50, Jeff Garzik wrote:
> It's a great idea, something I would like to do, and something I've =20
> suggested before.  You could dig through the mailing list archives, =20
> if you're motivated.

I have been digging through the archives; I was just holding out hope =20
that somebody else on the list had already halfway beat me to the =20
punch.  Guess not :-D

> I actively use git to version, store and distribute an exim mail =20
> configuration across six servers.  So far my solution has been a =20
> 'fix perms' script, or using the file perm checking capabilities of =20
> cfengine.
>
> But it would be a lot better if git natively cared about ownership =20
> and permissions (presumably via an option).

I was thinking about a standard config option in the GIT config file, =20
that way users could have a personal default and repositories could =20
specify it locally.

I started tinkering but quickly discovered that permissions handling =20
in general in GIT seems to be a mess; there's about 4 different tiers =20
where permissions data is manipulated in various formats.  Some =20
places use network-endian 16-bit values, there's a couple functions =20
which do different truncations to 644 or 755 format.  There are 2 =20
functions which canonicalize the file mode based on symlink or =20
directory status, each in subtly different ways.

I'm slowly sorting through things but if I could get a few pointers =20
from someone intimately familiar with the code that would be most =20
appreciated:  I'd like to try to add new entries to tree objects =20
which older versions of GIT would ignore but which newer versions of =20
GIT would use to store ACL or extended-attribute data.

The simplest solution which admittedly breaks the ability of older =20
GITs to read the data from a file with attributes (ignoring the ext-=20
attrs themselves) is to create a new "file-with-extended-attributes" =20
object which contains a binary concatenation (with length bytes and =20
attribute names and such) of the file and its extended attributes.  =20
That breaks the old GIT assumption that permission and security data =20
is part of the directory not the file, but it's more in-line with the =20
way extended attributes are attached to the inodes in the filesystem =20
(although that doesn't really matter IMO).

Alternatively I might be able to add a new entry to each tree object =20
with invalid extended file mods bits (IE: Neither a directory, a =20
file, nor a symlink), or perhaps an entry with an empty name, which =20
points to a new "extended attribute table".  That table could either =20
map from (entry, attribute) =3D> (data) or from (entry) =3D> =20
((attribute,data),(attribute,data),[...]), depending on which would =20
be more efficient.  It's essential that the overhead for non-ext-attr =20
repositories is O(1) and ideally the overhead for a bunch of files =20
with the same ext-attr is O(size-of-ext-attr) + O(number-of-files-=20
with-that-attr), although that may vary depending on implementation.

Advice, opinions, problems, and "this-has-no-chance-of-ever-even-=20
remotely-working" are all useful and welcome!

Cheers,
Kyle Moffett
