From: Ira Weiny <weiny2@llnl.gov>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Thu, 9 Apr 2009 11:18:38 -0700
Message-ID: <20090409111838.c79d532f.weiny2@llnl.gov>
References: <20090407133329.57b06727.weiny2@llnl.gov>
	<20090408080824.GF8940@machine.or.cz>
	<20090408083955.GA28482@pengutronix.de>
	<20090408091949.8a648d83.weiny2@llnl.gov>
	<20090409124337.GA6034@pengutronix.de>
	<36ca99e90904091034m4d4d31dct78acb333612e678@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__9_Apr_2009_11_18_38_-0700_XnD8iq+l_=FqjR74"
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 20:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrzCt-00067w-NV
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 20:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936142AbZDISjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 14:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935872AbZDISjw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 14:39:52 -0400
Received: from nspiron-1.llnl.gov ([128.115.41.81]:6882 "EHLO
	nspiron-1.llnl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935494AbZDISjv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 14:39:51 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Apr 2009 14:39:51 EDT
X-Attachments: 0001-Add-list-and-rm-sub-commands-to-tg-depend.patch
Received: from mail-2.llnl.gov ([128.115.41.181])
  by nspiron-1.llnl.gov with ESMTP; 09 Apr 2009 11:29:59 -0700
Received: from jeepcj7.llnl.gov (jeepcj7.llnl.gov [134.9.93.67])
	by mail-2.llnl.gov (8.13.1/8.12.3/LLNL evision: 1.7 $) with SMTP id n39IJA00012586;
	Thu, 9 Apr 2009 11:19:11 -0700
In-Reply-To: <36ca99e90904091034m4d4d31dct78acb333612e678@mail.gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.4; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116195>

This is a multi-part message in MIME format.

--Multipart=_Thu__9_Apr_2009_11_18_38_-0700_XnD8iq+l_=FqjR74
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Apr 2009 19:34:06 +0200
Bert Wesarg <bert.wesarg@googlemail.com> wrote:

> 2009/4/9 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> > Hello Ira,
> >
> > On Wed, Apr 08, 2009 at 09:19:49AM -0700, Ira Weiny wrote:
> >> On Wed, 8 Apr 2009 10:39:55 +0200
> >> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
> >>

[snip]

> >> > > > + =A0 =A0 =A0 mv $TMPFILE $root_dir/.topdeps
> >> > > > +else
> >> > > > + =A0 =A0 =A0 echo "$name" >>"$root_dir/.topdeps"
> >> > > > +fi
> >> > > > +
> >> > > > +## commit it and update this branch
> >> > > > =A0git add -f "$root_dir/.topdeps"
> >> > > > =A0git commit -m"New TopGit dependency: $name"
> >> > > > =A0$tg update
> >> > > > --
> >> > > > 1.5.4.5
> >> > I don't think the patch is correct. =A0Just removing a branch from
> >> > .topdeps is not enough.
> >> >
> >> > Did you try to export the tg-branch? =A0The result will be that the =
patch
> >> > for that you deleted the dependency has the deleted change folded in.
> >>
> >> Indeed you are correct. =A0It was working for me because I was moving =
a node
> >> from one place to another. =A0But the new location was still an ancest=
or of the
> >> dependency which was removed. =A0I still think this can be automated b=
ut I will
> >> have to work on it.
> > So you mean that rm should only work if the patch is still a dependency?
> >
> > You might want to check
> >
> > =A0 =A0 =A0 =A0http:// thread.gmane.org/gmane.comp.version-control.git/=
114581
> >
> > before investing time to implement it. =A0(I cc:d Bert Wesarg.) =A0If y=
ou
> > had posted to git@vger.kernel.org Bert might have seen your mail alone.
> > (hint hint)
> Uwe,
>=20
> thanks for the Cc.
>=20
> I really can't reconstruct this thread, could some one send me the
> original patch.

I have attached the original patch (cleaned up with Uwe's original comments=
).

NOTE: this will not work but I am just sending it to help reconstruct the
thread.

I think to do this properly you would have to either A) create a new branch
without the topic specified B) work your way back through the dependencies =
and
reverse patch all those nodes which do not have a common ancestor with any =
of
your other dependencies.  As an aside I found that topgit does not like you
removing the only dependency left.  I was unable to get that to work at all.
I don't know why.

I believe you specified option A in a message after this one, correct?

Ira

>
> My interest is this, that I implemented a tg-prev
> (lists all deps from given topic), tg-next (lists topics depending on
> the given topic), and a tg-tsort (which gives a topological list of
> dependencies, which is a little outdated after the --graphviz option)
>=20
> The original message seems lost in the archive, the comments are still th=
ere:
>=20
> http:// thread.gmane.org/gmane.comp.version-control.git/96483
>=20
> I can send an update on this.
>=20
> I think the first two commands could be added as sub-commands to
> tg-depend, with bash completion you don't need to type that much
> nowadays.
>=20
> As I said to tg-tsort, its probably outdated because of the graphviz
> output, but may still provide valid information.  Btw. does anyone
> know a console output driver for the graphviz tools, i.e. dot and co?
>=20
> Bert
>=20
> >
> > Best regards
> > Uwe
>=20
> PS: Finally added git list to Cc:
>=20


--=20
Ira Weiny
Math Programmer/Computer Scientist
Lawrence Livermore National Lab
weiny2@llnl.gov

--Multipart=_Thu__9_Apr_2009_11_18_38_-0700_XnD8iq+l_=FqjR74
Content-Type: application/octet-stream;
 name="0001-Add-list-and-rm-sub-commands-to-tg-depend.patch"
Content-Disposition: attachment;
 filename="0001-Add-list-and-rm-sub-commands-to-tg-depend.patch"
Content-Transfer-Encoding: base64

RnJvbSAzYTQyNGExODg3YTgxNWNhNzQyZWY0YmFjZWMwOWIyNDU2NThiMWI3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBJcmEgV2VpbnkgPHdlaW55MkBsbG5sLmdvdj4KRGF0ZTogVHVl
LCA3IEFwciAyMDA5IDEzOjAzOjQ4IC0wNzAwClN1YmplY3Q6IFtQQVRDSF0gQWRkICJsaXN0IiBh
bmQgInJtIiBzdWIgY29tbWFuZHMgdG8gdGctZGVwZW5kCgoKU2lnbmVkLW9mZi1ieTogSXJhIFdl
aW55IDx3ZWlueTJAbGxubC5nb3Y+Ci0tLQogUkVBRE1FICAgICAgIHwgICAxNiArKysrKysrKysr
KysrLS0tCiB0Zy1kZXBlbmQuc2ggfCAgIDI3ICsrKysrKysrKysrKysrKysrKysrKysrKystLQog
MiBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL1JFQURNRSBiL1JFQURNRQppbmRleCBkMmYwOTVkLi44YjQzNTZkIDEwMDY0NAotLS0g
YS9SRUFETUUKKysrIGIvUkVBRE1FCkBAIC0yNTYsOCArMjU2LDEzIEBAIHRnIGRlbGV0ZQogdGcg
ZGVwZW5kCiB+fn5+fn5+fn4KIAlDaGFuZ2UgZGVwZW5kZW5jaWVzIG9mIGEgVG9wR2l0LWNvbnRy
b2xsZWQgdG9waWMgYnJhbmNoLgotCVRoaXMgc2hvdWxkIGhhdmUgc2V2ZXJhbCBzdWJjb21tYW5k
cywgYnV0IG9ubHkgJ2FkZCcgaXMKLQlzdXBwb3J0ZWQgcmlnaHQgbm93LgorCVRoaXMgY29tbWFu
ZCBoYXMgdGhlIHN1YmNvbW1hbmRzOgorCQknbGlzdCcgIDw9PSBEZWZhdWx0IChydW4gd2hlbiBu
byBzdWJjb21tYW5kIGlzIGdpdmVuKQorCQknYWRkJworCQkncm0nCisKKwknbGlzdCcgbGlzdHMg
dGhlIHRvcGljIGJyYW5jaGVzIG9uIHdoaWNoIHRoZSBjdXJyZW50IHRvcGljIGJyYW5jaAorCWRl
cGVuZHMuCiAKIAlUaGUgJ2FkZCcgc3ViY29tbWFuZCB0YWtlcyBhbiBhcmd1bWVudCBvZiBhIHRv
cGljIGJyYW5jaAogCXRvIGJlIGFkZGVkLCBhZGRzIGl0IHRvICcudG9wZGVwcycsIHBlcmZvcm1z
IGEgY29tbWl0IGFuZApAQCAtMjY2LDcgKzI3MSwxMiBAQCB0ZyBkZXBlbmQKIAlhZGp1c3Rpbmcg
Jy50b3Btc2cnLCBwcmVwYXJlIHRoZW0gaW4gdGhlIGluZGV4IGJlZm9yZQogCWNhbGxpbmcgJ3Rn
IGRlcGVuZCBhZGQnLgogCi0JVE9ETzogU3ViY29tbWFuZCBmb3IgcmVtb3ZpbmcgZGVwZW5kZW5j
aWVzLCBvYnZpb3VzbHkKKwlUaGUgJ3JtJyBzdWJjb21tYW5kIHRha2VzIGFuIGFyZ3VtZW50IG9m
IGEgdG9waWMgYnJhbmNoCisJdG8gYmUgcmVtb3ZlZCwgcmVtb3ZlcyBpdCBmcm9tICcudG9wZGVw
cycsIHBlcmZvcm1zIGEgY29tbWl0IGFuZAorCXRoZW4gdXBkYXRlcyB5b3VyIHRvcGljIGJyYW5j
aCBhY2NvcmRpbmdseS4gSWYgeW91IHdhbnQgdG8KKwlkbyBvdGhlciB0aGluZ3MgcmVsYXRlZCB0
byB0aGUgZGVwZW5kZW5jeSBhZGRpdGlvbiwgbGlrZQorCWFkanVzdGluZyAnLnRvcG1zZycsIHBy
ZXBhcmUgdGhlbSBpbiB0aGUgaW5kZXggYmVmb3JlCisJY2FsbGluZyAndGcgZGVwZW5kIHJtJy4K
IAogdGcgaW5mbwogfn5+fn5+fgpkaWZmIC0tZ2l0IGEvdGctZGVwZW5kLnNoIGIvdGctZGVwZW5k
LnNoCmluZGV4IGVmNWY5NGYuLjZhNGJjODUgMTAwNjQ0Ci0tLSBhL3RnLWRlcGVuZC5zaAorKysg
Yi90Zy1kZXBlbmQuc2gKQEAgLTQsMTYgKzQsMjUgQEAKICMgR1BMdjIKIAogbmFtZT0KK21vZGU9
CiAKIAogIyMgUGFyc2Ugb3B0aW9ucwogCiBzdWJjbWQ9IiQxIjsgc2hpZnQgfHwgOgogY2FzZSAi
JHN1YmNtZCIgaW4KLQktaHwiIikKKwktaCkKIAkJZWNobyAiVXNhZ2U6IHRnIFsuLi5dIGRlcGVu
ZCBhZGQgTkFNRSIgPiYyCiAJCWV4aXQgMTs7CiAJYWRkKQorCQltb2RlPSJhZGQiCisJCTs7CisJ
IiJ8bGlzdCkKKwkJY2F0ICRyb290X2Rpci8udG9wZGVwcworCQlleGl0IDAKKwkJOzsKKwlybSkK
KwkJbW9kZT0icm0iCiAJCTs7CiAJKikKIAkJZGllICJ1bmtub3duIHN1YmNvbW1hbmQgKCRzdWJj
bWQpIjs7CkBAIC00Myw3ICs1MiwyMSBAQCBiYXNlcmV2PSIkKGdpdCByZXYtcGFyc2UgLS12ZXJp
ZnkgInJlZnMvdG9wLWJhc2VzLyRuYW1lIiAyPi9kZXYvbnVsbCkiIHx8CiAKICMjIFJlY29yZCBu
ZXcgZGVwZW5kZW5jeQogCi1lY2hvICIkbmFtZSIgPj4iJHJvb3RfZGlyLy50b3BkZXBzIgoraWYg
WyAiJG1vZGUiID0gInJtIiBdOyB0aGVuCisJZ3JlcCAkbmFtZSAkcm9vdF9kaXIvLnRvcGRlcHMg
PiAvZGV2L251bGwKKwlpZiBbICIkPyIgIT0gIjAiIF07IHRoZW4KKwkJZWNobyAiRmFpbGVkIHRv
IGZpbmQgJG5hbWUgaW4gZGVwZW5kZW5jeSBsaXN0IgorCQlleGl0IDEKKwlmaQorCVRNUEZJTEU9
YG1rdGVtcGAgfHwgZXhpdCAxCisJZWNobyAkVE1QRklMRQorCWdyZXAgLXYgJG5hbWUgJHJvb3Rf
ZGlyLy50b3BkZXBzID4gJFRNUEZJTEUKKwltdiAkVE1QRklMRSAkcm9vdF9kaXIvLnRvcGRlcHMK
K2Vsc2UKKwllY2hvICIkbmFtZSIgPj4iJHJvb3RfZGlyLy50b3BkZXBzIgorZmkKKworIyMgY29t
bWl0IGl0IGFuZCB1cGRhdGUgdGhpcyBicmFuY2gKIGdpdCBhZGQgLWYgIiRyb290X2Rpci8udG9w
ZGVwcyIKIGdpdCBjb21taXQgLW0iTmV3IFRvcEdpdCBkZXBlbmRlbmN5OiAkbmFtZSIKICR0ZyB1
cGRhdGUKLS0gCjEuNS40LjUKCg==

--Multipart=_Thu__9_Apr_2009_11_18_38_-0700_XnD8iq+l_=FqjR74--
