Received: from send215.i.mail.ru (send215.i.mail.ru [95.163.59.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A14C77BB
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.163.59.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788785803; cv=none; b=WEjCD6lDOWg7tkaNMcZUd2YnInybxvyj02+reVfJkK662MlhdxuvQTqE48XLLOxX1IieuPsyJ1uJDozPWIyTPudoKeVOTh9paVzELEkP2m3qGhHFFq/c0UULIJHs49+N3+Tg9A/fSlev4Q8oztbsnyI2SWv2QeC7w+BkHRba6yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788785803; c=relaxed/simple;
	bh=Xec+S24LQKgfbbmEQ2PjnIGBbV65eNk7deEBdCNA/8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SOohT/wrm5Asx+BiyOFgtIcAflMHIzTGLDYcZlroUICXBD+3tzA9tu2m+S10YiqpIMVVHZhKBXx3fUJxl96wOwf75VKGaiz7CJAHCwK506qucgRWVH39um9VLAh1BfDFuavra2Mv7PtcWKQLszXtVLMgCe9706L9l9IO9tHVxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru; spf=pass smtp.mailfrom=mail.ru; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=ln8jfJL4; dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b=jjjtPLOE; arc=none smtp.client-ip=95.163.59.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mail.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="ln8jfJL4";
	dkim=pass (2048-bit key) header.d=mail.ru header.i=@mail.ru header.b="jjjtPLOE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive:X-Cloud-Ids;
	bh=XkcmBiLLL8ffhZeGfVmChekXo9+IAK0PDW7Cq1ZJzng=; t=1788785793; x=1788875793; 
	b=ln8jfJL43JwQn78e2JKDLmW5+/abRj+KR6EUnBhnFJWATarUGJm5az1ZHHXNKSppiLKgQZgovqw
	a6sQ9YLKEseDz/lJgFesDOQjOpapibwVQqkXZDMKUlmLqD92F32lSo/AD2f5fvDqOCZrkRcoh3OCE
	gG4pG5GwyHISV39tEwNxMpU2p6Z2/t0cs5RO/vmUXhBatPErtHf/Kpu/eAdTQVrVA/0zcKwAaGEwp
	zH6kEn/GEgS08JlPD1obLS2vf/EC3hEmmlbCCwLn5TeeEqQ/NGd56yHv+aW2xJ2WRDyuQa9CpZ/G1
	zvQT7dUbSXvKkajSkcswmU6E3SzqVGMsie8A==;
Received: from [10.113.97.100] (port=44384 helo=send128.i.mail.ru)
	by exim-fallback-679568fb9b-7tngq with esmtp (envelope-from <ub4nal@mail.ru>)
	id 1x3YtZ-00000000BH0-0wzX
	for git@vger.kernel.org; Mon, 07 Sep 2026 15:56:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
	s=mail4; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:
	To:From:From:Sender:Reply-To:To:Cc:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive:
	X-Cloud-Ids:Disposition-Notification-To;
	bh=XkcmBiLLL8ffhZeGfVmChekXo9+IAK0PDW7Cq1ZJzng=; t=1788785781; x=1788875781; 
	b=jjjtPLOE+ktHr2EcvLdRad5q/kPPCWWXjkvakHlps2TZf248yivGduhQaflgjUnjJfM0b5pYVEQ
	YieKem3hPXfwxygnf/nSBUvfvFIwKLGJxvD1xDtyhXMdybIVHDJVHOz2jsgP232Rt9EI+oIAKcx+0
	fdGpcJVLPpGB+4jYukW/bsNGTgqOv/3NpHAPNAFSRfOtveoJDLEMzPOZYtNFlvxMyhFzMhcsg8wzW
	l1aezgWN5dkst/0U8qQ1HzYV6perE5LF0XOosUYr/E5bCzQBnu0I2T0/05177tJTGUzEwEEUAkWOh
	cy+23RWiOAdevmg2ifdYqZo8q1LVbvbMvGQQ==;
Received: by exim-smtp-569b45c49c-z9dfm with esmtpa (envelope-from <ub4nal@mail.ru>)
	id 1x3YtQ-000000001RJ-1snw; Mon, 07 Sep 2026 15:56:12 +0300
Received: from vatem (localhost.localdomain [127.0.0.1])
	by vatem.localdomain (Postfix) with ESMTP id D33E49F633;
	Mon,  7 Sep 2026 15:56:11 +0300 (MSK)
From: Vsevolod Myalitsin <ub4nal@mail.ru>
To: git@vger.kernel.org
Cc: Vsevolod Myalitsin <ub4nal@mail.ru>
Subject: [PATCH] advice: use global config for default branch name
Date: Mon,  7 Sep 2026 15:56:09 +0300
Message-ID: <20260907125610.23458-1-ub4nal@mail.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD968A9E3B9DC3E6DB183EEDAA3DA4B2A7192A137F17A8DA995182A05F53808504055CF562CDAE707D63DE06ABAFEAF6705380C6A132C1FA3F57E605DAABF73511EF649426FA9741B02
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7CB1634DB9A2F7B99EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637AC83A81C8FD4AD23D82A6BABE6F325AC2E85FA5F3EDFCBAA7353EFBB5533756682FC6F8CF4E8B7272EFB3DEC817DB0D8EAFE5053E29CE8AAF580FB744627A3ED8EEF46B7454FC60B9742502CCDD46D0DB861051D4BA689FCF6B57BC7E64490618DEB871D839B73339E8FC8737B5C224901F8F2FECC0250C8CC7F00164DA146DAFE8445B8C89999729449624AB7ADAF37F6B57BC7E64490611E7FA7ABCAF51C92176DF2183F8FC7C0B27420F9988F54058941B15DA834481F9449624AB7ADAF37BA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0272DDD408E5FE5607B076A6E789B0E97A8DF7F3B2552694AD5FFEEA1DED7F25D49FD398EE364050FCCD848CCB6FE560CA68A47777D5C6D9CB3661434B16C20ACC84D3B47A649675FE827F84554CEF5019E625A9149C048EE33AC447995A7AD182BEBFE083D3B9BA73A03B725D353964B0B7D0EA88DDEDAC722CA9DD8327EE4933F735096452955E3444A83B712AC0148C4224003CC83647689D4C264860C145E
X-C1DE0DAB: 0D63561A33F958A5523E7A8629AB4DFA5002B1117B3ED69602C89247D60F810030E4A65F242F5898823CB91A9FED034534781492E4B8EEADF12279BA039A6965C79554A2A72441328621D336A7BC284946AD531847A6065A17B107DEF921CE79BDAD6C7F3747799A
X-C8649E89: 1C3962B70DF3F0AD73CAD6646DEDE191716CD42B3DD1D34C77DD89D51EBB774225B6776AC983F447FC0B9F89525902EE6F57B2FD27647F25E66C117BDB76D65953DD9FC3A48122C39F2494184EC1A3243E5DE4B9A94C98C5FBFB34BA2DC195C57666EEDE6B8CCC8FB8341EE9D5BE9A0A3A22D15DFA75B3C17D6C756288F9F73ED44701B143BBEADE8CD93680B12512CF4C41F94D744909CEFACD6B4B6D928230F8CCC96A59B602D5CC2E138FFB4ACBED
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+ObcCpyrx6l7KImUglyhkEat/+ysWwi0gdhEs0JGjl6ggRWTy1haxBpVdbIX1nthFXOcIETfglQORZ0zpDET4Zrk3igikrdHlWN0ahGgtOrE0DLEd9SnCO68=
X-Mailru-Sender: 288943BA7BCC8BBA065C24D5D0D78BBD559D4A0D8E0B4EB03DE06ABAFEAF6705380C6A132C1FA3F5A165F1893FAC5C75730F10A35ECD6C905A92E71CC7C3152D8DFEC3831B33C4D004BC3E28E37B34A4E9BE5789416A142FC25A2993B28EC86D9FF92CA8FAC60DF8EAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Mailru-Src: fallback
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B49A33C8AABF03C2F7F5DD75A6CD6FF65AA59D56933CB21E86049FFFDB7839CE9E656977AF4D7889C97A57C5020460F54FE7CD808BA7404DFCAE2420C2C4203DD9E86FAB092591067A
X-7FA49CB5: 0D63561A33F958A5D18BFE2360A573EE5002B1117B3ED6968974DBE95E3F4AAF477B8DB6B08738FF02ED4CEA229C1FA827C277FBC8AE2E8B54F520D093A0DF28
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu53w8ahmwBjZKM/YPHZyZHvz5uv+WouB9+OYcBso8Zm+oliTz8oZwnDrFsY77LZRcHyw5ht0smWrfSeTW5FiI8avd9v29gUBslpLaIlvAR6h4id02YH9mgeCTAyYoNlVO8a5LOd0Z6w/fc/6fRdNTWYqs=
X-Mailru-MI: 20000000020000000000000800
X-Mras: Ok

The advice for configuring the default branch name
suggests disabling it with "git config set
advice.defaultBranchName false". This setting is
useless because it neither affects the current
repository nor newly created repositories.

Suggest using "git config --global" instead.

Signed-off-by: Vsevolod Myalitsin <ub4nal@mail.ru>
---
 advice.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/advice.c b/advice.c
index 63bf8b0c5f..64ca4613b4 100644
--- a/advice.c
+++ b/advice.c
@@ -96,7 +96,7 @@ static struct {
 
 static const char turn_off_instructions[] =
 N_("\n"
-   "Disable this message with \"git config set advice.%s false\"");
+   "Disable this message with \"git config %s advice.%s false\"");
 
 static void vadvise(const char *advice, int display_instructions,
 		    const char *key, va_list params)
@@ -107,7 +107,8 @@ static void vadvise(const char *advice, int display_instructions,
 	strbuf_vaddf(&buf, advice, params);
 
 	if (display_instructions)
-		strbuf_addf(&buf, turn_off_instructions, key);
+		strbuf_addf(&buf, turn_off_instructions,
+			strcmp(key, "defaultBranchName") ? "set" : "--global", key);
 
 	for (cp = buf.buf; *cp; cp = np) {
 		np = strchrnul(cp, '\n');
-- 
2.50.1

