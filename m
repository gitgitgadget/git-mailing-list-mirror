From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Re: [PATCH] gitweb: Support for snapshot
Date: Sat, 19 Aug 2006 13:40:31 +0530
Message-ID: <cc723f590608190110t68e6de8etbf6b5b002fd83ca1@mail.gmail.com>
References: <44E54AC6.9010600@gmail.com>
	 <20060818195148.66411.qmail@web31807.mail.mud.yahoo.com>
	 <7v64gp7prk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7167_4883135.1155975031548"
Cc: "Luben Tuikov" <ltuikov@yahoo.com>, git@vger.kernel.org,
	"jakub narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 19 10:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GELuf-0007EM-Pq
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 10:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWHSIKe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 04:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWHSIKe
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 04:10:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:8241 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751434AbWHSIKd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 04:10:33 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1481261nfa
        for <git@vger.kernel.org>; Sat, 19 Aug 2006 01:10:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=pI6tZtfMvyKJX5Fkq729NzPL81OQDdjk8cB1vXYzn0yIR8bJ+mw6GeBRivXHx9L6E758fiH600R8lY2iulxrX8jQmd70r44Xc3srRNvFP1gvcuhK6DMG6Zj5FuzrtB9v5g0cKIEYlAoYnZQ9p3ySB0Fh6d0/bvFJQkoa3KIscrM=
Received: by 10.48.48.18 with SMTP id v18mr5011243nfv;
        Sat, 19 Aug 2006 01:10:31 -0700 (PDT)
Received: by 10.49.57.9 with HTTP; Sat, 19 Aug 2006 01:10:31 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v64gp7prk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25708>

------=_Part_7167_4883135.1155975031548
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/19/06, Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
>
> > --- "Aneesh Kumar K.V" <aneesh.kumar@gmail.com> wrote:
> >> This adds snapshort support in gitweb. To enable one need to
> >> set gitweb.snapshot = true in the config file.
> >
> > Could you use bzip2?  It generates smaller files (better compression),
> > which is a good thing when downloading over a network.
>
> Because bzip2 is heavier on the server than gzip is (and gzip is
> heavier than "gzip -1" is), there obviously is a trade-off.  We
> would want it to be configurable just like blame and snapshot
> itself.
>
> Maybe:
>
>         config.snapshot = no | yes | gzip | bzip2 ...
>
> By the way, I think it is a mistake to use only $GIT_DIR/config
> to control these features.
>

I have coded this at

What should be the content-encoding in this case x-$snapshot ?

This is the untested diff that i have. Is this what we are looking for ?


-aneesh

------=_Part_7167_4883135.1155975031548
Content-Type: text/x-patch; name="gitweb.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gitweb.diff"
X-Attachment-Id: f_er1po1ya

ZGlmZiAtLWdpdCBhL2dpdHdlYi9naXR3ZWIucGVybCBiL2dpdHdlYi9naXR3ZWIucGVybAppbmRl
eCBmOGQxMDM2Li42YWQzMTQxIDEwMDc1NQotLS0gYS9naXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIv
Z2l0d2ViL2dpdHdlYi5wZXJsCkBAIC02Nyw2ICs2NywxNSBAQCAjIGZpbGUgdG8gdXNlIGZvciBn
dWVzc2luZyBNSU1FIHR5cGVzIGJlCiAjIChyZWxhdGl2ZSB0byB0aGUgY3VycmVudCBnaXQgcmVw
b3NpdG9yeSkKIG91ciAkbWltZXR5cGVzX2ZpbGUgPSB1bmRlZjsKIAorIyBkb24ndCBlbmFibGUg
c25hcHNob3Qgc3VwcG9ydCBieSBkZWZhdWx0CisjIHBvc3NpYmxlIHZhbHVlcyBhcmUgbm98Z3pp
cHxiemlwMnwKK291ciAkc25hcHNob3QgPSAibm8iOworCisjIHRoaXMgaW5kaWNhdGUgd2hldGhl
ciB0aGUgc25hcHNob3Qgc3VwcG9ydCBjYW4gYmUgb3ZlcnJpZGRlbgorIyBieSBhIHByb2plY3Qg
c3BlY2lmaWMgY29uZmlnLgorIyBwb3NzaWJsZSB2YWx1ZXMgYXJlIHllc3xubworb3VyICRzbmFw
c2hvdF9vdmVycmlkZSA9ICJubyI7CisKIG91ciAkR0lUV0VCX0NPTkZJRyA9ICRFTlZ7J0dJVFdF
Ql9DT05GSUcnfSB8fCAiKytHSVRXRUJfQ09ORklHKysiOwogcmVxdWlyZSAkR0lUV0VCX0NPTkZJ
RyBpZiAtZSAkR0lUV0VCX0NPTkZJRzsKIApAQCAtMTM5Nyw3ICsxNDA2LDcgQEAgc3ViIGdpdF9k
aWZmdHJlZV9ib2R5IHsKIHN1YiBnaXRfc2hvcnRsb2dfYm9keSB7CiAJIyB1c2VzIGdsb2JhbCB2
YXJpYWJsZSAkcHJvamVjdAogCW15ICgkcmV2bGlzdCwgJGZyb20sICR0bywgJHJlZnMsICRleHRy
YSkgPSBAXzsKLQlteSAkaGF2ZV9zbmFwc2hvdCA9IGdpdF9nZXRfcHJvamVjdF9jb25maWdfYm9v
bCgnc25hcHNob3QnKTsKKwlteSAoJGhhdmVfc25hcHNob3QsICRzbmFwc2hvdF9jb21wKSA9IGdp
dF9nZXRfcHJvamVjdF9zbmFwc2hvdF9jb25maWcoKTsKIAkkZnJvbSA9IDAgdW5sZXNzIGRlZmlu
ZWQgJGZyb207CiAJJHRvID0gJCN7JHJldmxpc3R9IGlmICghZGVmaW5lZCAkdG8gfHwgJCN7JHJl
dmxpc3R9IDwgJHRvKTsKIApAQCAtMjIwMCwxMyArMjIwOSwxNCBAQCBzdWIgZ2l0X3NuYXBzaG90
IHsKIAl9CiAKIAlteSAkZmlsZW5hbWUgPSBiYXNlbmFtZSgkcHJvamVjdCkgLiAiLSRoYXNoLnRh
ci5neiI7CisJbXkgKCRoYXZlX3NuYXBzaG90LCAkc25hcHNob3RfY29tcCkgPSBnaXRfZ2V0X3By
b2plY3Rfc25hcHNob3RfY29uZmlnKCk7CiAKIAlwcmludCAkY2dpLT5oZWFkZXIoLXR5cGUgPT4g
J2FwcGxpY2F0aW9uL3gtdGFyJywKLQkJCS1jb250ZW50LWVuY29kaW5nID0+ICd4LWd6aXAnLAor
CQkJLWNvbnRlbnQtZW5jb2RpbmcgPT4gIngtJHNuYXBzaG90X2NvbXAiLAogCQkJJy1jb250ZW50
LWRpc3Bvc2l0aW9uJyA9PiAiaW5saW5lOyBmaWxlbmFtZT1cIiRmaWxlbmFtZVwiIiwKIAkJCS1z
dGF0dXMgPT4gJzIwMCBPSycpOwogCi0Jb3BlbiBteSAkZmQsICItfCIsICIkR0lUIHRhci10cmVl
ICRoYXNoIFwnJHByb2plY3RcJyB8IGd6aXAiIG9yCisJb3BlbiBteSAkZmQsICItfCIsICIkR0lU
IHRhci10cmVlICRoYXNoIFwnJHByb2plY3RcJyB8ICRzbmFwc2hvdF9jb21wIiBvcgogCQkJCWRp
ZV9lcnJvcih1bmRlZiwgIkV4ZWN1dGUgZ2l0LXRhci10cmVlIGZhaWxlZC4iKTsKIAliaW5tb2Rl
IFNURE9VVCwgJzpyYXcnOwogCXByaW50IDwkZmQ+OwpAQCAtMjIxNSw2ICsyMjI1LDI3IEBAIHN1
YiBnaXRfc25hcHNob3QgewogCiAKIH0KK3N1YiBnaXRfZ2V0X3Byb2plY3Rfc25hcHNob3RfY29u
ZmlnKCkKK3sKKwlteSAkc25hcDsKKworCWlmICgkc25hcHNob3QgPX4gbS9uby8pIHsKKwkJcmV0
dXJuICgwLCB1bmRlZik7CisJfQorCisJaWYgKCRzbmFwc2hvdF9vdmVycmlkZSA9fiBtL25vLykg
eworCQlyZXR1cm4gKDEsICRzbmFwc2hvdCk7CisJfQorCisJJHNuYXAgPSBnaXRfZ2V0X3Byb2pl
Y3RfY29uZmlnKCdzbmFwc2hvdCcpOworCisJaWYgKCRzbmFwIGFuZCAkc25hcCA9fiBtL25vLykg
eworCQlyZXR1cm4gKDAsIHVuZGVmKTsKKwl9CisJcmV0dXJuICgxLCAkc25hcCk7Cit9CisKK30K
IAogc3ViIGdpdF9sb2cgewogCW15ICRoZWFkID0gZ2l0X2dldF9oZWFkX2hhc2goJHByb2plY3Qp
OwpAQCAtMjI5Myw3ICsyMzI0LDcgQEAgc3ViIGdpdF9jb21taXQgewogCX0KIAlteSAkcmVmcyA9
IGdpdF9nZXRfcmVmZXJlbmNlcygpOwogCW15ICRyZWYgPSBmb3JtYXRfcmVmX21hcmtlcigkcmVm
cywgJGNveydpZCd9KTsKLQlteSAkaGF2ZV9zbmFwc2hvdCA9IGdpdF9nZXRfcHJvamVjdF9jb25m
aWdfYm9vbCgnc25hcHNob3QnKTsKKwlteSAoJGhhdmVfc25hcHNob3QsICRzbmFwc2hvdF9jb21w
KSA9IGdpdF9nZXRfcHJvamVjdF9zbmFwc2hvdF9jb25maWcoKTsKIAlteSAkZm9ybWF0c19uYXYg
PSAnJzsKIAlpZiAoZGVmaW5lZCAkZmlsZV9uYW1lICYmIGRlZmluZWQgJGNveydwYXJlbnQnfSkg
ewogCQlteSAkcGFyZW50ID0gJGNveydwYXJlbnQnfTsK
------=_Part_7167_4883135.1155975031548--
