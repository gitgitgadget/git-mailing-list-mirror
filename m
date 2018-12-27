Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBA34211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbeL0Opf (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 09:45:35 -0500
Received: from mout.web.de ([212.227.15.14]:52051 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbeL0Opf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 09:45:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1545921926;
        bh=xMvXrylhf1GfoQIGQmxRrvQmyZ15z4l4NTPsuf10tXY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=QanO98Ya3zsuQQ2HM5wBwXN+iGv+EUoQtGz53y/L+sLhaQ1NKB2ub1Gp/mbT6gz08
         otO9ECIwuAg0Knc7t/CYe+1+GnWlLsvEUp0XLfqDThU7IH0f6TfNqforAebvJ8Gr2K
         y3I9p7LW2REhxmhcZC5zpRSrvqofbI8s7Yr/v8/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MMIdp-1giKD50AGL-0080ZS; Thu, 27
 Dec 2018 15:45:26 +0100
Date:   Thu, 27 Dec 2018 15:45:25 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Alexandre Grigoriev <alegrigoriev@gmail.com>
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?'Adri=E1n?= Gimeno Balaguer' 
        <adrigibal@gmail.com>, git@vger.kernel.org
Subject: Re: git-rebase is ignoring working-tree-encoding
Message-ID: <20181227144525.GA2467@tor.lan>
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
 <20181104170729.GA21372@tor.lan>
 <CADN+U_MgrGHLQ5QNa-HgzxLN4zJLJPu4PaT2MTRoc18=gET+5Q@mail.gmail.com>
 <20181105181014.GA30777@tor.lan>
 <20181106201618.GA30158@tor.lan>
 <CADN+U_N345aMaiN4CT-_qsecw2gv=8-r+Hqq+CNz-xOx2KGYzg@mail.gmail.com>
 <20181108170230.GA6652@tor.lan>
 <002201d49cb5$cc554160$64ffc420$@gmail.com>
 <20181226192525.GB423984@genre.crustytoothpaste.net>
 <005601d49d8f$45c109b0$d1431d10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <005601d49d8f$45c109b0$d1431d10$@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Provags-ID: V03:K1:mARL2T68/tx9Lg1obkKmcrhH7KEgzZ2/EpVcNoVUsXB8COl/Ea8
 sEHvkhvJXtZvYEhQdR/p3TaY/eBMKRifnh8N6y7PTrqV7O+m5h2ar+54pzRkwkU725LTsjh
 tIjeFsYbkXDrjJ3RDKHXr4wE/kO1/AfiYkxBvMSIXNmZPfqEUUwlnFn+Tt2g1vHJGsgTIup
 HOW1DdU5mKs5gMJ+wFIBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4oLkOSRqTms=:wleQLZq8PDdRyj/i5HEIDh
 NDrmqVql46J1LlKqoxVMALSfw6rW040PdXKXxXkziR6ukq0C5Y3esvx64mT2bTiLhcEmB65zH
 IlsdqQUl8S4zJJd+XGpd4KrHzxxEZq04FoRuUYZTMEyavlaVARD5wgIB/31a6h1NDJXF5aMll
 8vCCCe4W5Wf7+gI5Zj6IxKllv4tOu3b3v8/5709UPX+FnyaJ2TlpWjNYBdgPfPU2YXEEyQbIh
 beX12SnJJc5Hcoo/teAUGoPhy/fZpouinW6nf5Ed5ihdIqdQv8s/78PTnI9RHI+V1mgtwLTNY
 LPyrgbF75NeLt5zk2VApTg3sk9IIbIud/8lC6ZJV3LmM2uePtujPQuLXWKpr+w0eE74VFssQ6
 bmsZBQdu0adaqtdWoIrIjUG5X2WhV2Up81TvyhznfE5+ZPkV0bjVc3wrkz3kcMfG/Ir6z2J1Q
 CL2DXECGRNtCULhH/kkNFWYyw0gkQ0LbfHutAcduv/hqCCCrBd5E+aZ5LHr3sNoWz+RHEjMPP
 QW/DrDpZQErmunggdRcdOsdZ1/2GQRF9av6NWvM0+2WvYij8+FwC0tN2tKkf7Vj8cJgd9lMXY
 2Gb3GV4jvGPVrDPIiVQwwfIhle5P5ltuiEKagyteGoOGiq4VlwCFyVBjaWyU/Rj2SrLBUSrJz
 e0etMjBPVhggfr8tB9K/BVSNuwLAs/qpqvtxVqwkVdKKldl4D61uGtimUuwWHSw9iX/ZDwK/l
 DPliIoyvBcTnN250fLgqr/bTXp6ItZ4nKmXEI6hJ9AyXju3s/UkKQaccfOx3ixTVpjPADWwlO
 y4yN3YILdovK+TT5FXRas4cEyY2AQstKyO/qFDl/BqRZkgQgDroLlqOyEpvB9jL0GCoyzms8S
 RdUufQj3Ao9JMEtDCSokNLoAVaygXUhhMiv691fBE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 26, 2018 at 06:52:56PM -0800, Alexandre Grigoriev wrote:
> 
> > -----Original Message-----
> > From: brian m. carlson [mailto:sandals@crustytoothpaste.net]
> > Sent: Wednesday, December 26, 2018 11:25 AM
> > To: Alexandre Grigoriev
> > Cc: 'Torsten Bögershausen'; 'Adrián Gimeno Balaguer'; git@vger.kernel.org
> > Subject: Re: git-rebase is ignoring working-tree-encoding
> > 
> > On Tue, Dec 25, 2018 at 04:56:11PM -0800, Alexandre Grigoriev wrote:
> > > Many tools in Windows still do not understand UTF-8, although it's
> > > getting better. I think Windows is about the only OS where tools still
> > > require
> > > UTF-16 for full internationalization.
> > > Many tools written in C use MSVC RTL, where fopen(), unfortunately,
> > > doesn't understand UTF-16BE (though such a rudimentary program as
> > Notepad does).
> > >
> > > For this reason, it's very reasonable to ask that the programming
> > > tools produce UTF-16 files with particular endianness, natural for the
> > > platform they're running on.
> > >
> > > The iconv programmers' boneheaded decision to always produce UTF-16BE
> > > with BOM for UTF-16 output doesn't make sense.
> > > Again, git and iconv/libiconv in Centos on x86 do the right thing and
> > > produce UTF-16LE with BOM in this case.
> > 
> > A program which claims to support "UTF-16" must support both
> > endiannesses, according to RFC 2781. A program writing UTF-16-LE must not
> > write a BOM at the beginning. I realize this is inconvenient, but the bad
> > behavior of some Windows programs doesn't mean that Git should ignore
> > interoperability with non-Windows systems using UTF-16 correctly in favor of
> > Windows.
> 
> OK, we have a choice either:
> a) to live in that corner of the real world where you have to use available tools, some of which have historical reasons
> to only support UTF-16LE with BOM, because nobody ever throws a different flavor of UTF-16 at them;
> Or b) to live in an ivory tower where you don't really need to use UTF-16 LE or BE or any other flavor,
> because everything is just UTF-8, and tell all those other people using that lame OS to shut up and wait until their tools start to support
> the formats you don't really have to care about;
> 
> > behavior of some Windows programs doesn't mean that Git should ignore
> > interoperability with non-Windows systems using UTF-16 correctly in favor of
> > Windows.
> 
> Yes, Git (actually libiconv) should not ignore interoperability.
> This means it should check out files on a *Windows* system in a format which *Windows* tools
> can understand.
> And, by the way, Centos (or RedHat?) developers understood that.
> There, on an x86 installation, when you ask for UTF-16, it produces UTF-16LE with BOM.
> Just as every user there would want.
> 
> 

Sorry if I feel confused here - does the problem still exist ?
If yes, does the following patch help ?



diff --git a/utf8.c b/utf8.c
index eb78587504..2facef84d4 100644
--- a/utf8.c
+++ b/utf8.c
@@ -9,6 +9,23 @@ struct interval {
 	ucs_char_t last;
 };
 
+static int has_bom_prefix(const char *data, size_t len,
+			  const char *bom, size_t bom_len)
+{
+	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
+}
+
+static const char utf16_be_bom[] = {'\xFE', '\xFF'};
+static const char utf16_le_bom[] = {'\xFF', '\xFE'};
+static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
+static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
+
+static inline uint16_t default_swab16(uint16_t val)
+{
+	return (((val & 0xff00) >>  8) |
+		((val & 0x00ff) <<  8));
+}
+
 size_t display_mode_esc_sequence_len(const char *s)
 {
 	const char *p = s;
@@ -556,21 +573,19 @@ char *reencode_string_len(const char *in, size_t insz,
 
 	out = reencode_string_iconv(in, insz, conv, outsz);
 	iconv_close(conv);
+	if (has_bom_prefix(out, *outsz, utf16_be_bom, sizeof(utf16_be_bom))) {
+		/* UTF-16 should be little endian under Git */
+		size_t    num_points = *outsz / sizeof(uint16_t);
+		uint16_t *point = (uint16_t*) out;
+		while (num_points--) {
+			*point = default_swab16(*point);
+			point++;
+		}
+	}
 	return out;
 }
 #endif
 
-static int has_bom_prefix(const char *data, size_t len,
-			  const char *bom, size_t bom_len)
-{
-	return data && bom && (len >= bom_len) && !memcmp(data, bom, bom_len);
-}
-
-static const char utf16_be_bom[] = {'\xFE', '\xFF'};
-static const char utf16_le_bom[] = {'\xFF', '\xFE'};
-static const char utf32_be_bom[] = {'\0', '\0', '\xFE', '\xFF'};
-static const char utf32_le_bom[] = {'\xFF', '\xFE', '\0', '\0'};
-
 int has_prohibited_utf_bom(const char *enc, const char *data, size_t len)
 {
 	return (


