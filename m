Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EB76207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S976027AbdDXRaD (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:30:03 -0400
Received: from mout.web.de ([212.227.15.3]:63326 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S976017AbdDXR37 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:29:59 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdVty-1cKGBc37J4-00injm; Mon, 24
 Apr 2017 19:29:54 +0200
Subject: [PATCH v3 1/5] archive-zip: add tests for big ZIP archives
To:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <7361b84d-41c4-8224-ff83-36703837eb28@web.de>
Date:   Mon, 24 Apr 2017 19:29:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:k7gRoegAWvpD5ZOQ7ukZMJ5GOq45u0HBzb072uTJgFA5pvIipMd
 jrRS/kD0lMFOBhICAwj5boJBs3ZCjUisvy20EzBoe3CNEVxssoZ7ZKVr0yoQVO8/RJUyd6F
 KtDXrGi4wYfQVP4T9btbraUacntIMVV/Hr8aP18gQyvmw7Z2FJDyXMjbOKHo6Kv9wWqYhmE
 9O3HtaViVidneJbLcqkOQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OtbX3D5fKCY=:CysgKQGBllSZPUYnDmzBs/
 L+sM0eamtP9hVe4eW5o0fZyd8CCJxdJhM+M83rt+6Yd1qNOALcutDu0AkgWg/10wl9xo0mb5b
 5Qd60bfCLM/1QttpJ/5QQkZbflJECu1qBLMI6HCVdr2bPQgb3UWNu/wWMvU9fIpxl019sidu1
 W9xLgr+d3WEDQ5flB70aX8RyLp7hHXhFbsugXMydMG+1KbgAL5HskjeUnWn6XXgkZFY/Q4gpJ
 ewHcoFu8igRgTGctIS/tAlkOousMj2ceXqZrztYodcdLiRnqQWORbsZdXPzAaGJgtz4p23ts8
 Hls8x6guuLynSuP94ksjY91fxRRYh8rWYYrPc43wRhoZZkeP0z/qbpwDH/cj53TdWwAnz2PAW
 JmvlLAKxpIvetjBKVQNcrUHwTkh3JP+QDNgIT6umMMTi6uA5NqA4Gvz3qBIPNbjO/TsEpHDGy
 ylOVOufPTROJyqeN/AzviKb/bSQ3jhg2RqT/cDq6/iiybolrG1G54E+bcsmlEFCSWVrhtmfB/
 ZVzzBLwtBP7FbpPVDSXp+/RjGm/JCgE/ch4jqMt6vfno44jzAK7JuOsGa58q2NhsDGJNij/LI
 nHn1C3VxyGjm2qwHmR090IkcDGuw/HPPyM+icsaKjaB6lLuEc2A55uRz8Ov1dgvgDvMWob/BT
 5P7sjFyY6SSMQKHbG3DcR7UBtqA341k1mbi4H8j/zuZIaDUKD5bNeo3SmR/YEn0qGmyCg5XDW
 TkO1xx0sIn7g1/ItkByyLk9L1/6YtTNVDJZKKnH6/QGzB+yRF/7AQnYzaggRryZNb5V8jYV2R
 jLsVffg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the creation of ZIP archives bigger than 4GB and containing files
bigger than 4GB.  They are marked as EXPENSIVE because they take quite a
while and because the first one needs a bit more than 4GB of disk space
to store the resulting archive.

The big archive in the first test is made up of a tree containing
thousands of copies of a small file.  Yet the test has to write out the
full archive because unzip doesn't offer a way to read from stdin.

The big file in the second test is provided as a zipped pack file to
avoid writing another 4GB file to disk and then adding it.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t5004-archive-corner-cases.sh |  45 ++++++++++++++++++++++++++++++++++++++++
 t/t5004/big-pack.zip            | Bin 0 -> 7373 bytes
 2 files changed, 45 insertions(+)
 create mode 100644 t/t5004/big-pack.zip

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index cca23383c5..bc052c803a 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -155,4 +155,49 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 	test_cmp expect actual
 '
 
+test_expect_failure EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
+	# build string containing 65536 characters
+	s=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef &&
+	s=$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s &&
+	s=$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s &&
+
+	# create blob with a length of 65536 + 1 bytes
+	blob=$(echo $s | git hash-object -w --stdin) &&
+
+	# create tree containing 65500 entries of that blob
+	for i in $(test_seq 1 65500)
+	do
+		echo "100644 blob $blob	$i"
+	done >tree &&
+	tree=$(git mktree <tree) &&
+
+	# zip it, creating an archive a bit bigger than 4GB
+	git archive -0 -o many-big.zip $tree &&
+
+	"$GIT_UNZIP" -t many-big.zip 9999 65500 &&
+	"$GIT_UNZIP" -t many-big.zip
+'
+
+test_expect_failure EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files bigger than 4GB' '
+	# Pack created with:
+	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
+	mkdir -p .git/objects/pack &&
+	(
+		cd .git/objects/pack &&
+		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/big-pack.zip
+	) &&
+	blob=754a93d6fada4c6873360e6cb4b209132271ab0e &&
+	size=$(expr 4100 "*" 1024 "*" 1024) &&
+
+	# create a tree containing the file
+	tree=$(echo "100644 blob $blob	big-file" | git mktree) &&
+
+	# zip it, creating an archive with a file bigger than 4GB
+	git archive -o big.zip $tree &&
+
+	"$GIT_UNZIP" -t big.zip &&
+	"$ZIPINFO" big.zip >big.lst &&
+	grep $size big.lst
+'
+
 test_done
diff --git a/t/t5004/big-pack.zip b/t/t5004/big-pack.zip
new file mode 100644
index 0000000000000000000000000000000000000000..caaf614eeece6f818c525e433561e37560a75b05
GIT binary patch
literal 7373
zcmWIWW@Zs#U}E54xLY#A%SmVLl4u471|Jp%215oJhJwW8Y+ZvC^HlQ`3(KT5gS6zd
z#6$y=#3VyYlN6KGlw?bTG()50MB`LTb5p&{l#0+0P6p<OAOA*xaA^fM10%}|W(Ec@
z@jL#}{4)m*95`aY)ux;vb9C_xiI`WWKX0v%wv#-XR%01$R>-9-y6#!_6|EcGQyxED
zyZY^&^YwM2r?Wic_gf3wz0#?R{8hB^<Js4()@9Ms>$gt{iHiUEJN{iALjZ~|R(VzA
zOp{_@IDE*S!H8sEfc%Wl8*lHd?-DJPX@5BLD~n)>se}uQ{sHa{9CBhhi*hb3*-*jg
zc5o4&4%_XW4Ba<OG7P)VrhVaOTdmN<Ho4-C?R3NUpAYE!{5{5hc=zr*JFR#QUppur
z?|(T<>b?Enk9jiu`<7qbA8y|-Ck>2+hMBYN-pgCcFt>ev-5*|-&jb`JE>Hh`B*~cT
z&t2=?C44}E8GDaU*PD0ekK%{l7w@(f14RzJnfvea+fQlS75nRoU$s?(g=&R(fOLb%
zK_JPHAqeJ(fjJ$>oKcz4&>2l3kc=^!7e@2KXkHl23k(gTVK5p7z>;7z9gKznQp0()
zeK6WS7;PVn){Ud}!f4$%I)=h9I*!CJ8V10UU^E?!h5@KqG@1@Z!(cQWK$^#7<%OS{
z_HQoT!K!n;di%NDON?i(ygj-((dOTWgOj)4mXFhko42#<@9S6BTc6*5|Cc?$n~_P5
z8P`mn1SleafRRC^5k!+Qug40R*F&4rL$?-n>J8c2V<cM(nTW$>FDo0!BTPW}9!Q@6
I&6hC%0B76lcmMzZ

literal 0
HcmV?d00001

-- 
2.12.2

