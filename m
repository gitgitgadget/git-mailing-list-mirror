From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 08:54:58 -0500
Message-ID: <484E87B2.2090506@gmail.com>
References: <484D78BF.6030504@gmail.com> <20080610063328.GB26965@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020709010705040109050407"
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: =?UTF-8?B?S2FybCBIYXNzZWxzdHLDtm0=?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 15:56:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K64KL-0006yu-OP
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 15:55:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755578AbYFJNzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 09:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755373AbYFJNzE
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 09:55:04 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:11446 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755578AbYFJNzB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 09:55:01 -0400
Received: by py-out-1112.google.com with SMTP id p76so1208512pyb.10
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type;
        bh=jShLSWil1GMaw3HzumrMmm99SNA5G+a9vvITPaRyvF8=;
        b=HFg7EpPlD2AQ91GqBMs4DG6JKnku2kPS2CDv4kkNj5Dl53ozeu2hYoLAPD+QascZU5
         2uMmrA5c48FmypZdzL3lxdGasD0mcH9MwYZWZsMYwgAE2qVrxFEg1zMJoDz9LIhTVH+P
         IXplsPaqefRi6m5vjTxUVHxEDLmN8UqMJbjIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        b=EDmbxfc6eVgY6BSvzNwLHNHkSRy87Yiie3doi5Dqhde5ZKomAUq6PA9UItxkp6L3Nu
         8yJ9ydHkRA5biyY3GPz4kb/ywh/BfkRFquivcIsoBGrFVMRqz2mKYBruxR4L1Uzj/NyC
         orqxcPXx4yZFXY3+gK2NilJGv6RJOTdKT476s=
Received: by 10.115.60.1 with SMTP id n1mr4877655wak.179.1213106100168;
        Tue, 10 Jun 2008 06:55:00 -0700 (PDT)
Received: from ?192.168.2.37? ( [74.239.78.188])
        by mx.google.com with ESMTPS id 6sm66093ywn.0.2008.06.10.06.54.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 06:54:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <20080610063328.GB26965@diana.vm.bytemark.co.uk>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84502>

This is a multi-part message in MIME format.
--------------020709010705040109050407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Karl Hasselström wrote:
> 
> Some comments here:
> 
>   * By my reading of the docs, the second argument to BZ2File defaults
>     to 'r' anyway, so you could omit it.
> 
>   * We try to use single quotes wherever possible (except when triple
>     quoting). You're using a mix ...
> 
>   * .replace() will happily replace anywhere in the string. Please
>     consider using stgit.util.strip_suffix() instead.
> 
> And last but not least, it'd be terrific if you'd let me bully you
> into adding .gz and .bz2 test cases for t1800-import. :-)
> 

Sigh. Never reply before your second cup of coffee.

Updated patch attached.

Clark

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhOh7EACgkQqA4JVb61b9c4BgCeJH0GUzQJCDdJ8gx5287KE/KO
uTwAoKD7V4JMqHnYmFCg01ij5aBbLDbq
=Yy/n
-----END PGP SIGNATURE-----

--------------020709010705040109050407
Content-Type: text/plain;
 name="compressed-input.patch"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="compressed-input.patch"

UGF0Y2ggdG8gYWxsb3cgaW1wb3J0IGZyb20gY29tcHJlc3NlZCAoLmd6IGFuZCAuYnoyKSBm
aWxlcwoKRnJvbTogQ2xhcmsgV2lsbGlhbXMgPHdpbGxpYW1zQHJlZGhhdC5jb20+CgpTaWdu
ZWQtb2ZmLWJ5OiBDbGFyayBXaWxsaWFtcyA8d2lsbGlhbXNAcmVkaGF0LmNvbT4KLS0tCgog
c3RnaXQvY29tbWFuZHMvaW1wcnQucHkgfCAgIDIxICsrKysrKysrKysrKysrKy0tLS0tLQog
MSBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3N0Z2l0L2NvbW1hbmRzL2ltcHJ0LnB5IGIvc3RnaXQvY29tbWFuZHMvaW1w
cnQucHkKaW5kZXggNGE0Yjc5Mi4uMDUwMzAxYSAxMDA2NDQKLS0tIGEvc3RnaXQvY29tbWFu
ZHMvaW1wcnQucHkKKysrIGIvc3RnaXQvY29tbWFuZHMvaW1wcnQucHkKQEAgLTE3OCw4ICsx
NzgsMjIgQEAgZGVmIF9fY3JlYXRlX3BhdGNoKGZpbGVuYW1lLCBtZXNzYWdlLCBhdXRob3Jf
bmFtZSwgYXV0aG9yX2VtYWlsLAogZGVmIF9faW1wb3J0X2ZpbGUoZmlsZW5hbWUsIG9wdGlv
bnMsIHBhdGNoID0gTm9uZSk6CiAgICAgIiIiSW1wb3J0IGEgcGF0Y2ggZnJvbSBhIGZpbGUg
b3Igc3RhbmRhcmQgaW5wdXQKICAgICAiIiIKKyAgICBpZiBwYXRjaDoKKyAgICAgICAgcG5h
bWUgPSBwYXRjaAorICAgIGVsc2U6CisgICAgICAgIHBuYW1lID0gZmlsZW5hbWUKKwogICAg
IGlmIGZpbGVuYW1lOgotICAgICAgICBmID0gZmlsZShmaWxlbmFtZSkKKyAgICAgICAgaWYg
ZmlsZW5hbWUuZW5kc3dpdGgoJy5neicpOgorICAgICAgICAgICAgaW1wb3J0IGd6aXAKKyAg
ICAgICAgICAgIGYgPSBnemlwLm9wZW4oZmlsZW5hbWUpCisgICAgICAgICAgICBwbmFtZSA9
IHN0cmlwX3N1ZmZpeCgnLmd6JywgZmlsZW5hbWUpCisgICAgICAgIGVsaWYgZmlsZW5hbWUu
ZW5kc3dpdGgoJy5iejInKToKKyAgICAgICAgICAgIGltcG9ydCBiejIKKyAgICAgICAgICAg
IGYgPSBiejIuQloyRmlsZShmaWxlbmFtZSkKKyAgICAgICAgICAgIHBuYW1lID0gc3RyaXBf
c3VmZmljKCcuYnoyJywgZmlsZW5hbWUpCisgICAgICAgIGVsc2U6CisgICAgICAgICAgICBm
ID0gZmlsZShmaWxlbmFtZSkKICAgICBlbHNlOgogICAgICAgICBmID0gc3lzLnN0ZGluCiAK
QEAgLTE5NywxMSArMjExLDYgQEAgZGVmIF9faW1wb3J0X2ZpbGUoZmlsZW5hbWUsIG9wdGlv
bnMsIHBhdGNoID0gTm9uZSk6CiAgICAgaWYgZmlsZW5hbWU6CiAgICAgICAgIGYuY2xvc2Uo
KQogCi0gICAgaWYgcGF0Y2g6Ci0gICAgICAgIHBuYW1lID0gcGF0Y2gKLSAgICBlbHNlOgot
ICAgICAgICBwbmFtZSA9IGZpbGVuYW1lCi0KICAgICBfX2NyZWF0ZV9wYXRjaChwbmFtZSwg
bWVzc2FnZSwgYXV0aG9yX25hbWUsIGF1dGhvcl9lbWFpbCwKICAgICAgICAgICAgICAgICAg
ICBhdXRob3JfZGF0ZSwgZGlmZiwgb3B0aW9ucykKIAo=
--------------020709010705040109050407--
