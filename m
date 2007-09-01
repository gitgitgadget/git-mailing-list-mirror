From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] git-tag: Fix -l option to use better shell style globs.
Date: Sat, 1 Sep 2007 16:33:50 +0200
Message-ID: <1b46aba20709010733x45960f00g8732f6a1af363768@mail.gmail.com>
References: <46D8F431.70801@gmail.com>
	 <7v8x7qvrka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3129_23285062.1188657230443"
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 01 16:34:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRU2z-0004BG-5Z
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 16:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbXIAOdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Sep 2007 10:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753680AbXIAOdw
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 10:33:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:45586 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753659AbXIAOdv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Sep 2007 10:33:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1300038wah
        for <git@vger.kernel.org>; Sat, 01 Sep 2007 07:33:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=o8xC3UM3PkeF+fmx299V6lxSYd/UQKf700syAxaTtRhyJdS5g325W+924qYDK1IJxqRLocddfiGTciOl0g5Xz50CtGJaDSBopK+O64TemYGP8RZsZxpufQCIa02hTXGWClMPzeYRshLU4shrYXCvRAFO37koYnGWVqa3YUyGwzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=uNB4s/xKZGaS0KtRRvJeAiEN7/y6o9oYFdjvLqputGd+Sv/KUtjKePwAOZeO5fNztR3nzgaYJNdFvlQ0y+0VQK77G0LUoF/nyf6G0ZhovscmFnvDd/AXraZqtMv1FT/TCDTl3t6lNhp8OQ/GNdq8rNhOXGvY5fEdWDf99n/3kaU=
Received: by 10.143.16.9 with SMTP id t9mr131386wfi.1188657230491;
        Sat, 01 Sep 2007 07:33:50 -0700 (PDT)
Received: by 10.143.10.14 with HTTP; Sat, 1 Sep 2007 07:33:50 -0700 (PDT)
In-Reply-To: <7v8x7qvrka.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57274>

------=_Part_3129_23285062.1188657230443
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/9/1, Junio C Hamano <gitster@pobox.com>:
> I think it is conceptually simpler on the show_reference side to
> allow (filter.pattern == NULL) and say:
>
>         if (!filter->pattern || !fnmatch(filter->pattern, refname, 0)) {
>                 ... show that ref ...
>         }
>
> It is not such a big deal now you do not do newpattern
> allocation anymore, so I'll apply the patch as is.
>

You are right. I changed the patch also to reflect this.
I cannot send a reply using my email client now, so I send it
attached to this response to avoid gmail breaks in long lines.

------=_Part_3129_23285062.1188657230443
Content-Type: text/x-patch; 
	name=0001-git-tag-Fix-l-option-to-use-better-shell-style-globs.patch; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f627smyj
Content-Disposition: attachment; filename="0001-git-tag-Fix-l-option-to-use-better-shell-style-globs.patch"

RnJvbSBkMTAxNzBjNWEyYzNjZjFmYzZhZDI3MGU5YTJjODJmZjI5YTk4ODcxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDYXJsb3MgUmljYSA8amFzYW1wbGVyQGdtYWlsLmNvbT4KRGF0
ZTogU2F0LCAxIFNlcCAyMDA3IDA2OjU4OjQwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZ2l0LXRh
ZzogRml4IC1sIG9wdGlvbiB0byB1c2UgYmV0dGVyIHNoZWxsIHN0eWxlIGdsb2JzLgoKVGhpcyBw
YXRjaCByZW1vdmVzIHRoZSBiZWhhdmlvdXIgb2YgImdpdCB0YWcgLWwgZm9vIiwgY3VycmVudGx5
Cmxpc3RpbmcgZXZlcnkgdGFnIG5hbWUgaGF2aW5nICJmb28iIGFzIGEgc3Vic3RyaW5nLiAgVGhl
IHNhbWUKdGhpbmcgbm93IGNvdWxkIGJlIGFjaGlldmVkIGRvaW5nICJnaXQgdGFnIC1sICcqZm9v
KiciLgoKVGhlICJmZWF0dXJlIiB3YXMgYWRkZWQgcmVjZW50bHkgd2hlbiBnaXQtdGFnLnNoIGdv
dCB0aGUgLW4gb3B0aW9uCmZvciBzaG93aW5nIHRhZyBhbm5vdGF0aW9ucywgYmVjYXVzZSB0aGF0
IGNvbW1pdCBhbHNvIHJlcGxhY2VkIHRoZQpvbGQgImdyZXAgcGF0dGVybiIgYmVoYXZpb3VyIHdp
dGggYSBtb3JlIHByZWZlcmFibGUgInNoZWxsIHBhdHRlcm4iCmJlaGF2aW91ciAoYWx0aG91Z2gg
c2xpZ2h0bHkgbW9kaWZpZWQgYXMgeW91IGNhbiBzZWUpLgpUaHVzLCB0aGUgZm9sbG93aW5nIGJ1
aWx0aW4tdGFnLmMgaW1wbGVtZW50ZWQgaXQgaW4gb3JkZXIgdG8KZW5zdXJlIHRoYXQgdGVzdHMg
d2VyZSBwYXNzaW5nIHVuY2hhbmdlZCB3aXRoIGJvdGggcHJvZ3JhbXMuCgpTaW5jZSBjb21tb24g
InNoZWxsIHBhdHRlcm5zIiBtYXRjaCBuYW1lcyB3aXRoIGEgZ2l2ZW4gc3Vic3RyaW5nCl9vbmx5
XyB3aGVuICogaXMgaW5zZXJ0ZWQgYmVmb3JlIGFuZCBhZnRlciAoYXMgaW4gIipzdWJzdHIqIiks
IGFuZAp0aGUgInBsYWluIiBiZWhhdmlvdXIgY2Fubm90IGJlIGFjaGlldmVkIGVhc2lseSB3aXRo
IHRoZSBjdXJyZW50CmltcGxlbWVudGF0aW9uLCB0aGlzIGlzIG1vc3RseSB0aGUgcmlnaHQgdGhp
bmcgdG8gZG8sIGluIG9yZGVyIHRvCm1ha2UgaXQgbW9yZSBmbGV4aWJsZSBhbmQgY29uc2lzdGVu
dC4KClRlc3RzIGZvciAiZ2l0IHRhZyIgd2VyZSBhbHNvIGNoYW5nZWQgdG8gcmVmbGVjdCB0aGlz
LgoKU2lnbmVkLW9mZi1ieTogQ2FybG9zIFJpY2EgPGphc2FtcGxlckBnbWFpbC5jb20+Ci0tLQog
YnVpbHRpbi10YWcuYyAgfCAgIDE0ICsrLS0tLS0tLS0tLS0tCiB0L3Q3MDA0LXRhZy5zaCB8ICAg
MjAgKysrKysrKysrLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygr
KSwgMjMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi10YWcuYyBiL2J1aWx0aW4t
dGFnLmMKaW5kZXggZDZkMzhhZC4uMGUwMWI5OCAxMDA2NDQKLS0tIGEvYnVpbHRpbi10YWcuYwor
KysgYi9idWlsdGluLXRhZy5jCkBAIC03NSw3ICs3NSw3IEBAIHN0YXRpYyBpbnQgc2hvd19yZWZl
cmVuY2UoY29uc3QgY2hhciAqcmVmbmFtZSwgY29uc3QgdW5zaWduZWQgY2hhciAqc2hhMSwKIHsK
IAlzdHJ1Y3QgdGFnX2ZpbHRlciAqZmlsdGVyID0gY2JfZGF0YTsKIAotCWlmICghZm5tYXRjaChm
aWx0ZXItPnBhdHRlcm4sIHJlZm5hbWUsIDApKSB7CisJaWYgKCFmaWx0ZXItPnBhdHRlcm4gfHwg
IWZubWF0Y2goZmlsdGVyLT5wYXR0ZXJuLCByZWZuYW1lLCAwKSkgewogCQlpbnQgaTsKIAkJdW5z
aWduZWQgbG9uZyBzaXplOwogCQllbnVtIG9iamVjdF90eXBlIHR5cGU7CkBAIC0xMjMsMjIgKzEy
MywxMiBAQCBzdGF0aWMgaW50IHNob3dfcmVmZXJlbmNlKGNvbnN0IGNoYXIgKnJlZm5hbWUsIGNv
bnN0IHVuc2lnbmVkIGNoYXIgKnNoYTEsCiBzdGF0aWMgaW50IGxpc3RfdGFncyhjb25zdCBjaGFy
ICpwYXR0ZXJuLCBpbnQgbGluZXMpCiB7CiAJc3RydWN0IHRhZ19maWx0ZXIgZmlsdGVyOwotCWNo
YXIgKm5ld3BhdHRlcm47CiAKLQlpZiAocGF0dGVybiA9PSBOVUxMKQotCQlwYXR0ZXJuID0gIiI7
Ci0KLQkvKiBwcmVwZW5kL2FwcGVuZCAqIHRvIHRoZSBzaGVsbCBwYXR0ZXJuOiAqLwotCW5ld3Bh
dHRlcm4gPSB4bWFsbG9jKHN0cmxlbihwYXR0ZXJuKSArIDMpOwotCXNwcmludGYobmV3cGF0dGVy
biwgIiolcyoiLCBwYXR0ZXJuKTsKLQotCWZpbHRlci5wYXR0ZXJuID0gbmV3cGF0dGVybjsKKwlm
aWx0ZXIucGF0dGVybiA9IHBhdHRlcm47CiAJZmlsdGVyLmxpbmVzID0gbGluZXM7CiAKIAlmb3Jf
ZWFjaF90YWdfcmVmKHNob3dfcmVmZXJlbmNlLCAodm9pZCAqKSAmZmlsdGVyKTsKIAotCWZyZWUo
bmV3cGF0dGVybik7Ci0KIAlyZXR1cm4gMDsKIH0KIApkaWZmIC0tZ2l0IGEvdC90NzAwNC10YWcu
c2ggYi90L3Q3MDA0LXRhZy5zaAppbmRleCBjNGZhNDQ2Li42MDZkNGYyIDEwMDc1NQotLS0gYS90
L3Q3MDA0LXRhZy5zaAorKysgYi90L3Q3MDA0LXRhZy5zaApAQCAtMTg1LDE4ICsxODUsMTcgQEAg
Y2JhCiBFT0YKIHRlc3RfZXhwZWN0X3N1Y2Nlc3MgXAogCSdsaXN0aW5nIHRhZ3Mgd2l0aCBzdWJz
dHJpbmcgYXMgcGF0dGVybiBtdXN0IHByaW50IHRob3NlIG1hdGNoaW5nJyAnCi0JZ2l0LXRhZyAt
bCBhID4gYWN0dWFsICYmCisJZ2l0LXRhZyAtbCAiKmEqIiA+IGFjdHVhbCAmJgogCWdpdCBkaWZm
IGV4cGVjdCBhY3R1YWwKICcKIAogY2F0ID5leHBlY3QgPDxFT0YKIHYwLjIuMQogdjEuMC4xCi12
MS4xLjMKIEVPRgogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0JJ2xpc3RpbmcgdGFncyB3aXRoIHN1
YnN0cmluZyBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKLQlnaXQtdGFn
IC1sIC4xID4gYWN0dWFsICYmCisJJ2xpc3RpbmcgdGFncyB3aXRoIGEgc3VmZml4IGFzIHBhdHRl
cm4gbXVzdCBwcmludCB0aG9zZSBtYXRjaGluZycgJworCWdpdC10YWcgLWwgIiouMSIgPiBhY3R1
YWwgJiYKIAlnaXQgZGlmZiBleHBlY3QgYWN0dWFsCiAnCiAKQEAgLTIwNSwzNyArMjA0LDM2IEBA
IHQyMTAKIHQyMTEKIEVPRgogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0JJ2xpc3RpbmcgdGFncyB3
aXRoIHN1YnN0cmluZyBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKLQln
aXQtdGFnIC1sIHQyMSA+IGFjdHVhbCAmJgorCSdsaXN0aW5nIHRhZ3Mgd2l0aCBhIHByZWZpeCBh
cyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKKwlnaXQtdGFnIC1sICJ0MjEq
IiA+IGFjdHVhbCAmJgogCWdpdCBkaWZmIGV4cGVjdCBhY3R1YWwKICcKIAogY2F0ID5leHBlY3Qg
PDxFT0YKIGExCi1hYTEKIEVPRgogdGVzdF9leHBlY3Rfc3VjY2VzcyBcCi0JJ2xpc3RpbmcgdGFn
cyB1c2luZyBhIG5hbWUgYXMgcGF0dGVybiBtdXN0IHByaW50IHRob3NlIG1hdGNoaW5nJyAnCisJ
J2xpc3RpbmcgdGFncyB1c2luZyBhIG5hbWUgYXMgcGF0dGVybiBtdXN0IHByaW50IHRoYXQgb25l
IG1hdGNoaW5nJyAnCiAJZ2l0LXRhZyAtbCBhMSA+IGFjdHVhbCAmJgogCWdpdCBkaWZmIGV4cGVj
dCBhY3R1YWwKICcKIAogY2F0ID5leHBlY3QgPDxFT0YKIHYxLjAKLXYxLjAuMQogRU9GCiB0ZXN0
X2V4cGVjdF9zdWNjZXNzIFwKLQknbGlzdGluZyB0YWdzIHVzaW5nIGEgbmFtZSBhcyBwYXR0ZXJu
IG11c3QgcHJpbnQgdGhvc2UgbWF0Y2hpbmcnICcKKwknbGlzdGluZyB0YWdzIHVzaW5nIGEgbmFt
ZSBhcyBwYXR0ZXJuIG11c3QgcHJpbnQgdGhhdCBvbmUgbWF0Y2hpbmcnICcKIAlnaXQtdGFnIC1s
IHYxLjAgPiBhY3R1YWwgJiYKIAlnaXQgZGlmZiBleHBlY3QgYWN0dWFsCiAnCiAKIGNhdCA+ZXhw
ZWN0IDw8RU9GCit2MS4wLjEKIHYxLjEuMwogRU9GCiB0ZXN0X2V4cGVjdF9zdWNjZXNzIFwKIAkn
bGlzdGluZyB0YWdzIHdpdGggPyBpbiB0aGUgcGF0dGVybiBzaG91bGQgcHJpbnQgdGhvc2UgbWF0
Y2hpbmcnICcKLQlnaXQtdGFnIC1sICIxLjE/IiA+IGFjdHVhbCAmJgorCWdpdC10YWcgLWwgInYx
Lj8uPyIgPiBhY3R1YWwgJiYKIAlnaXQgZGlmZiBleHBlY3QgYWN0dWFsCiAnCiAKLS0gCjEuNS4w
Cgo=
------=_Part_3129_23285062.1188657230443--
