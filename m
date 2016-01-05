From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 2/2] do_compare_entry: use already-computed path
Date: Tue, 05 Jan 2016 14:40:58 -0500
Organization: Twitter
Message-ID: <1452022858.3892.48.camel@twopensource.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
	 <1450737260-15965-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-SecpQQn9/JjUKxNdp++W"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 20:41:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGXTk-0007Pv-7j
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 20:41:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbcAETlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 14:41:03 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:36860 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688AbcAETlB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 14:41:01 -0500
Received: by mail-qg0-f46.google.com with SMTP id e32so196350832qgf.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 11:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version;
        bh=Z0c3FnwiZwTePojO5BlSL49IXZ7zDWJHm26G52oaPsM=;
        b=mKU8WOwtIoIPXVLoXd6I4Q1kvTnh1+kCk5OjhA9KigkfsHR4+gPnU30YplZhj0kIDJ
         zyjP00xBfKwnU2szh2lDNcokKWjNB0MglFFwyi/dwj3x+2iUlTEnk2wSCRscvalwY5LV
         0YNzqGFB+iWLgnvL2K0TiXxUG173fTKpNhNzTSHa8Kq058BGZEjqG+JS80mFUU+O0rFW
         RYEy6TujosCEOI/Y+Cdc4NevWCe8mH+UdcTXln1s8kG6Z2OLZQxMTxrPUZe0ZsXEmZyc
         Lc24Dgfo/sBKptT2j0gsYBuEVvmWflK2Z4qBrTN8HMlPoztHpoUvP8Mq1yRx27CQOSgc
         mUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version;
        bh=Z0c3FnwiZwTePojO5BlSL49IXZ7zDWJHm26G52oaPsM=;
        b=VK9ox1L708mj+VQ9EDrC2v5Wl8rq7bqLcbUB98DTePRCCQG4GrS9bdNlEIgVGujDxx
         ng59SwRNzjNNsPmDjLD/zaWygy+anNZyQ8+i/cq6mYd3xJYkAwWZBeQtiNlbDbqWaZU7
         GPpHtyK78szmNxUjXIl1h9iQxTFP3xp/6+EVjGvjJsbavgIwkUOXz6HAd/DbqTvRU76j
         NVWLikj2ZI08/0E6kJIj/LMkoSXqJaCbCCTKQ5LR5Rg0SJjNL/Cg+04ZFbSTz3dynstO
         0gzTcvOpOWmuarkqtFhoKzI3egB66boicG2Qq05sJKMBQTAGAbOea4a1Ki4c2Llizszi
         +AFw==
X-Gm-Message-State: ALoCoQm98hZoOpWd7XziQjcnLxeSzA4V8TXal149n54O2KV/lPFxnd404ZkTLGCJ7RVHFVBtvKKti/0S5ssoO/uRpa8vAbNgaQ==
X-Received: by 10.140.201.20 with SMTP id w20mr67895590qha.10.1452022860255;
        Tue, 05 Jan 2016 11:41:00 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 17sm42404317qhp.1.2016.01.05.11.40.58
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 11:40:59 -0800 (PST)
In-Reply-To: <1450737260-15965-3-git-send-email-dturner@twopensource.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283397>


--=-SecpQQn9/JjUKxNdp++W
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2015-12-21 at 17:34 -0500, David Turner wrote:
> In traverse_trees, we generate the complete traverse path for a

Please replace with the attached version, which eliminates an
unnecessary check.
--=-SecpQQn9/JjUKxNdp++W
Content-Disposition: attachment;
	filename="0001-do_compare_entry-use-already-computed-path.patch"
Content-Type: text/x-patch; name="0001-do_compare_entry-use-already-computed-path.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA1MjBjZmJmZjE1ZmFhNmRlNTBkMzdiNGE0NzZiMjFkYmUxNTk4NDMzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZpZCBUdXJuZXIgPGR0dXJuZXJAdHdvcGVuc291cmNlLmNv
bT4KRGF0ZTogTW9uLCAyMSBEZWMgMjAxNSAxNzozNDoyMCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hd
IGRvX2NvbXBhcmVfZW50cnk6IHVzZSBhbHJlYWR5LWNvbXB1dGVkIHBhdGgKCkluIHRyYXZlcnNl
X3RyZWVzLCB3ZSBnZW5lcmF0ZSB0aGUgY29tcGxldGUgdHJhdmVyc2UgcGF0aCBmb3IgYQp0cmF2
ZXJzZV9pbmZvLiAgTGF0ZXIsIGluIGRvX2NvbXBhcmVfZW50cnksIHdlIHVzZWQgdG8gZ28gZG8g
YSBidW5jaApvZiB3b3JrIHRvIGNvbXBhcmUgdGhlIHRyYXZlcnNlX2luZm8gdG8gYSBjYWNoZV9l
bnRyeSdzIG5hbWUgd2l0aG91dApjb21wdXRpbmcgdGhhdCBwYXRoLiAgQnV0IHNpbmNlIHdlIGFs
cmVhZHkgaGF2ZSB0aGF0IHBhdGgsIHdlIGRvbid0Cm5lZWQgdG8gZG8gYWxsIHRoYXQgd29yay4g
IEluc3RlYWQsIHdlIGNhbiBqdXN0IHB1dCB0aGUgZ2VuZXJhdGVkCnBhdGggaW50byB0aGUgdHJh
dmVyc2VfaW5mbywgYW5kIGRvIHRoZSBjb21wYXJpc29uIG1vcmUgZGlyZWN0bHkuCgpXZSBjb3B5
IHRoZSBwYXRoIGJlY2F1c2UgcHJ1bmVfdHJhdmVyc2FsIG1pZ2h0IG11dGF0ZSBgYmFzZWAuIFRo
aXMKZG9lc24ndCBoYXBwZW4gaW4gYW55IGNvZGVwYXRocyB3aGVyZSBkb19jb21wYXJlX2VudHJ5
IGlzIGNhbGxlZCwKYnV0IGl0J3MgYmV0dGVyIHRvIGJlIHNhZmUuCgpUaGlzIG1ha2VzIGdpdCBj
aGVja291dCBtdWNoIGZhc3RlciAtLSBhYm91dCAyNSUgb24gVHdpdHRlcidzCm1vbm9yZXBvLiAg
RGVlcGVyIGRpcmVjdG9yeSB0cmVlcyBhcmUgbGlrZWx5IHRvIGJlbmVmaXQgbW9yZSB0aGFuCnNo
YWxsb3dlciBvbmVzLgoKU2lnbmVkLW9mZi1ieTogRGF2aWQgVHVybmVyIDxkdHVybmVyQHR3b3Bl
bnNvdXJjZS5jb20+ClNpZ25lZC1vZmYtYnk6IEp1bmlvIEMgSGFtYW5vIDxnaXRzdGVyQHBvYm94
LmNvbT4KLS0tCiB0cmVlLXdhbGsuYyAgICB8ICA3ICsrKysrKysKIHRyZWUtd2Fsay5oICAgIHwg
IDEgKwogdW5wYWNrLXRyZWVzLmMgfCAzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystLQogMyBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RyZWUtd2Fsay5jIGIvdHJlZS13YWxrLmMKaW5kZXggNmRjY2QyZC4u
Y2Q0YmIyYyAxMDA2NDQKLS0tIGEvdHJlZS13YWxrLmMKKysrIGIvdHJlZS13YWxrLmMKQEAgLTMy
MCw2ICszMjAsNyBAQCBpbnQgdHJhdmVyc2VfdHJlZXMoaW50IG4sIHN0cnVjdCB0cmVlX2Rlc2Mg
KnQsIHN0cnVjdCB0cmF2ZXJzZV9pbmZvICppbmZvKQogCXN0cnVjdCB0cmVlX2Rlc2NfeCAqdHgg
PSB4Y2FsbG9jKG4sIHNpemVvZigqdHgpKTsKIAlzdHJ1Y3Qgc3RyYnVmIGJhc2UgPSBTVFJCVUZf
SU5JVDsKIAlpbnQgaW50ZXJlc3RpbmcgPSAxOworCWNoYXIgKnRyYXZlcnNlX3BhdGg7CiAKIAlm
b3IgKGkgPSAwOyBpIDwgbjsgaSsrKQogCQl0eFtpXS5kID0gdFtpXTsKQEAgLTMyOSw3ICszMzAs
MTEgQEAgaW50IHRyYXZlcnNlX3RyZWVzKGludCBuLCBzdHJ1Y3QgdHJlZV9kZXNjICp0LCBzdHJ1
Y3QgdHJhdmVyc2VfaW5mbyAqaW5mbykKIAkJbWFrZV90cmF2ZXJzZV9wYXRoKGJhc2UuYnVmLCBp
bmZvLT5wcmV2LCAmaW5mby0+bmFtZSk7CiAJCWJhc2UuYnVmW2luZm8tPnBhdGhsZW4tMV0gPSAn
Lyc7CiAJCXN0cmJ1Zl9zZXRsZW4oJmJhc2UsIGluZm8tPnBhdGhsZW4pOworCQl0cmF2ZXJzZV9w
YXRoID0geHN0cm5kdXAoYmFzZS5idWYsIGluZm8tPnBhdGhsZW4pOworCX0gZWxzZSB7CisJCXRy
YXZlcnNlX3BhdGggPSB4c3RybmR1cChpbmZvLT5uYW1lLnBhdGgsIGluZm8tPnBhdGhsZW4pOwog
CX0KKwlpbmZvLT50cmF2ZXJzZV9wYXRoID0gdHJhdmVyc2VfcGF0aDsKIAlmb3IgKDs7KSB7CiAJ
CWludCB0cmVlc191c2VkOwogCQl1bnNpZ25lZCBsb25nIG1hc2ssIGRpcm1hc2s7CkBAIC00MTEs
NiArNDE2LDggQEAgaW50IHRyYXZlcnNlX3RyZWVzKGludCBuLCBzdHJ1Y3QgdHJlZV9kZXNjICp0
LCBzdHJ1Y3QgdHJhdmVyc2VfaW5mbyAqaW5mbykKIAlmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKQog
CQlmcmVlX2V4dGVuZGVkX2VudHJ5KHR4ICsgaSk7CiAJZnJlZSh0eCk7CisJZnJlZSh0cmF2ZXJz
ZV9wYXRoKTsKKwlpbmZvLT50cmF2ZXJzZV9wYXRoID0gTlVMTDsKIAlzdHJidWZfcmVsZWFzZSgm
YmFzZSk7CiAJcmV0dXJuIGVycm9yOwogfQpkaWZmIC0tZ2l0IGEvdHJlZS13YWxrLmggYi90cmVl
LXdhbGsuaAppbmRleCAzYjJmN2JmLi4xNzRlYjYxIDEwMDY0NAotLS0gYS90cmVlLXdhbGsuaAor
KysgYi90cmVlLXdhbGsuaApAQCAtNTksNiArNTksNyBAQCBlbnVtIGZvbGxvd19zeW1saW5rc19y
ZXN1bHQgewogZW51bSBmb2xsb3dfc3ltbGlua3NfcmVzdWx0IGdldF90cmVlX2VudHJ5X2ZvbGxv
d19zeW1saW5rcyh1bnNpZ25lZCBjaGFyICp0cmVlX3NoYTEsIGNvbnN0IGNoYXIgKm5hbWUsIHVu
c2lnbmVkIGNoYXIgKnJlc3VsdCwgc3RydWN0IHN0cmJ1ZiAqcmVzdWx0X3BhdGgsIHVuc2lnbmVk
ICptb2RlKTsKIAogc3RydWN0IHRyYXZlcnNlX2luZm8geworCWNvbnN0IGNoYXIgKnRyYXZlcnNl
X3BhdGg7CiAJc3RydWN0IHRyYXZlcnNlX2luZm8gKnByZXY7CiAJc3RydWN0IG5hbWVfZW50cnkg
bmFtZTsKIAlpbnQgcGF0aGxlbjsKZGlmZiAtLWdpdCBhL3VucGFjay10cmVlcy5jIGIvdW5wYWNr
LXRyZWVzLmMKaW5kZXggOGUyMDMyZi4uNWY1NDFjMiAxMDA2NDQKLS0tIGEvdW5wYWNrLXRyZWVz
LmMKKysrIGIvdW5wYWNrLXRyZWVzLmMKQEAgLTQ5OCwxMyArNDk4LDE0IEBAIHN0YXRpYyBpbnQg
dHJhdmVyc2VfdHJlZXNfcmVjdXJzaXZlKGludCBuLCB1bnNpZ25lZCBsb25nIGRpcm1hc2ssCiAg
KiBpdHNlbGYgLSB0aGUgY2FsbGVyIG5lZWRzIHRvIGRvIHRoZSBmaW5hbCBjaGVjayBmb3IgdGhl
IGNhY2hlCiAgKiBlbnRyeSBoYXZpbmcgbW9yZSBkYXRhIGF0IHRoZSBlbmQhCiAgKi8KLXN0YXRp
YyBpbnQgZG9fY29tcGFyZV9lbnRyeShjb25zdCBzdHJ1Y3QgY2FjaGVfZW50cnkgKmNlLCBjb25z
dCBzdHJ1Y3QgdHJhdmVyc2VfaW5mbyAqaW5mbywgY29uc3Qgc3RydWN0IG5hbWVfZW50cnkgKm4p
CitzdGF0aWMgaW50IGRvX2NvbXBhcmVfZW50cnlfcGllY2V3aXNlKGNvbnN0IHN0cnVjdCBjYWNo
ZV9lbnRyeSAqY2UsIGNvbnN0IHN0cnVjdCB0cmF2ZXJzZV9pbmZvICppbmZvLCBjb25zdCBzdHJ1
Y3QgbmFtZV9lbnRyeSAqbikKIHsKIAlpbnQgbGVuLCBwYXRobGVuLCBjZV9sZW47CiAJY29uc3Qg
Y2hhciAqY2VfbmFtZTsKIAogCWlmIChpbmZvLT5wcmV2KSB7Ci0JCWludCBjbXAgPSBkb19jb21w
YXJlX2VudHJ5KGNlLCBpbmZvLT5wcmV2LCAmaW5mby0+bmFtZSk7CisJCWludCBjbXAgPSBkb19j
b21wYXJlX2VudHJ5X3BpZWNld2lzZShjZSwgaW5mby0+cHJldiwKKwkJCQkJCSAgICAgJmluZm8t
Pm5hbWUpOwogCQlpZiAoY21wKQogCQkJcmV0dXJuIGNtcDsKIAl9CkBAIC01MjIsNiArNTIzLDM5
IEBAIHN0YXRpYyBpbnQgZG9fY29tcGFyZV9lbnRyeShjb25zdCBzdHJ1Y3QgY2FjaGVfZW50cnkg
KmNlLCBjb25zdCBzdHJ1Y3QgdHJhdmVyc2VfCiAJcmV0dXJuIGRmX25hbWVfY29tcGFyZShjZV9u
YW1lLCBjZV9sZW4sIFNfSUZSRUcsIG4tPnBhdGgsIGxlbiwgbi0+bW9kZSk7CiB9CiAKK3N0YXRp
YyBpbnQgZG9fY29tcGFyZV9lbnRyeShjb25zdCBzdHJ1Y3QgY2FjaGVfZW50cnkgKmNlLAorCQkJ
ICAgIGNvbnN0IHN0cnVjdCB0cmF2ZXJzZV9pbmZvICppbmZvLAorCQkJICAgIGNvbnN0IHN0cnVj
dCBuYW1lX2VudHJ5ICpuKQoreworCWludCBsZW4sIHBhdGhsZW4sIGNlX2xlbjsKKwljb25zdCBj
aGFyICpjZV9uYW1lOworCWludCBjbXA7CisKKwkvKgorCSAqIElmIHdlIGhhdmUgbm90IHByZWNv
bXB1dGVkIHRoZSB0cmF2ZXJzZSBwYXRoLCBpdCBpcyBxdWlja2VyCisJICogdG8gYXZvaWQgZG9p
bmcgc28uICBCdXQgaWYgd2UgaGF2ZSBwcmVjb21wdXRlZCBpdCwKKwkgKiBpdCBpcyBxdWlja2Vy
IHRvIHVzZSB0aGUgcHJlY29tcHV0ZWQgdmVyc2lvbi4KKwkgKi8KKwlpZiAoIWluZm8tPnRyYXZl
cnNlX3BhdGgpCisJCXJldHVybiBkb19jb21wYXJlX2VudHJ5X3BpZWNld2lzZShjZSwgaW5mbywg
bik7CisKKwljbXAgPSBzdHJuY21wKGNlLT5uYW1lLCBpbmZvLT50cmF2ZXJzZV9wYXRoLCBpbmZv
LT5wYXRobGVuKTsKKwlpZiAoY21wKQorCQlyZXR1cm4gY21wOworCisJcGF0aGxlbiA9IGluZm8t
PnBhdGhsZW47CisJY2VfbGVuID0gY2VfbmFtZWxlbihjZSk7CisKKwlpZiAoY2VfbGVuIDwgcGF0
aGxlbikKKwkJcmV0dXJuIC0xOworCisJY2VfbGVuIC09IHBhdGhsZW47CisJY2VfbmFtZSA9IGNl
LT5uYW1lICsgcGF0aGxlbjsKKworCWxlbiA9IHRyZWVfZW50cnlfbGVuKG4pOworCXJldHVybiBk
Zl9uYW1lX2NvbXBhcmUoY2VfbmFtZSwgY2VfbGVuLCBTX0lGUkVHLCBuLT5wYXRoLCBsZW4sIG4t
Pm1vZGUpOworfQorCiBzdGF0aWMgaW50IGNvbXBhcmVfZW50cnkoY29uc3Qgc3RydWN0IGNhY2hl
X2VudHJ5ICpjZSwgY29uc3Qgc3RydWN0IHRyYXZlcnNlX2luZm8gKmluZm8sIGNvbnN0IHN0cnVj
dCBuYW1lX2VudHJ5ICpuKQogewogCWludCBjbXAgPSBkb19jb21wYXJlX2VudHJ5KGNlLCBpbmZv
LCBuKTsKLS0gCjIuNC4yLjc0OS5nNzMwNjU0ZC10d3Ryc3JjCgo=


--=-SecpQQn9/JjUKxNdp++W--
