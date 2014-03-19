From: Sylvestre Ledru <sylvestre@mozilla.com>
Subject: [BUG] Segfault on git describe
Date: Wed, 19 Mar 2014 11:48:27 +0100
Message-ID: <532975FB.9030803@mozilla.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080105090102060000080504"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 11:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQEA7-0006bo-2O
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 11:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758413AbaCSKzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2014 06:55:51 -0400
Received: from mx2.corp.phx1.mozilla.com ([63.245.216.70]:56920 "EHLO
	smtp.mozilla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbaCSKzt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 06:55:49 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Mar 2014 06:55:49 EDT
Received: from [10.243.29.87] (unknown [64.213.97.194])
	(Authenticated sender: sledru@mozilla.com)
	by mx2.mail.corp.phx1.mozilla.com (Postfix) with ESMTPSA id 16AF1F2494
	for <git@vger.kernel.org>; Wed, 19 Mar 2014 03:48:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244430>

This is a multi-part message in MIME format.
--------------080105090102060000080504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello,

Trying to do some stats using the Firefox git repository
(https://github.com/mozilla/gecko-dev), I found a bug
on git describe. The following command will segfault:
git describe --contains a9ff31aebd6dbda82a3c733a72eeeaa0b0525b96

Please note that the Firefox history is a pretty long and this commit
date is 2001.

I experience this issue with the git version, and Debian packages
(1.9.0-1 and 2.0~next.20140214-2)

As attachment, the backtrace. I removed about 87250 calls to the
name_rev function. I guess that is a potential source of problem.

Full is available here:
http://people.mozilla.org/~sledru/bt-git-on-ff.txt (21 MB)

I am available to test patches if needed.

Thanks,
Sylvestre
PS: I am not registered, please cc me.

--------------080105090102060000080504
Content-Type: text/plain; charset=UTF-8;
 name="bt-git-on-ff-small.txt"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="bt-git-on-ff-small.txt"

#0  inflate_table (type=type@entry=CODES, lens=0x178f230, codes=codes@entry=19, table=0x178f228, 
    bits=bits@entry=0x178f210, work=work@entry=0x178f4b0) at inftrees.c:39
        len = 0
        sym = <optimized out>
        min = <optimized out>
        max = <optimized out>
        root = <optimized out>
        curr = <optimized out>
        drop = <optimized out>
        left = <optimized out>
        used = <optimized out>
        huff = <optimized out>
        incr = <optimized out>
        fill = <optimized out>
        low = <optimized out>
        mask = <optimized out>
        here = <optimized out>
        next = <optimized out>
        base = <optimized out>
        extra = <optimized out>
        end = <optimized out>
        count = {0, 0, 0, 0, 0, 0, 0, 0, 31046, 360, 0, 0, 62288, 376, 0, 0}
        offs = {36858, 61615, 32767, 0, 0, 0, 0, 0, 127, 0, 0, 0, 65535, 65535, 0, 0}
        lbase = {3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51, 59, 67, 83, 99, 115, 131, 
          163, 195, 227, 258, 0, 0}
        lext = {16, 16, 16, 16, 16, 16, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 19, 19, 20, 20, 20, 20, 21, 
          21, 21, 21, 16, 72, 78}
        dbase = {1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385, 513, 769, 1025, 1537, 2049, 
          3073, 4097, 6145, 8193, 12289, 16385, 24577, 0, 0}
        dext = {16, 16, 16, 16, 17, 17, 18, 18, 19, 19, 20, 20, 21, 21, 22, 22, 23, 23, 24, 24, 25, 25, 26, 26, 27, 
          27, 28, 28, 29, 29, 64, 64}
#1  0x00007ffff7bce6fd in inflate (strm=0x7fffff7ff190, flush=4) at inflate.c:926
        state = 0x178f1a0
        next = 0x7fffb3b7e5b2 "?\305-LHU\355\070\315\271\002\006\220P\a\220\220\212\330\317\366%\265\232ĕ{\251\bOOڑ\221\177\270\341t\337w\277\024f\360hLͨu\323\006\252\254\213\232\235\363\326qh=\326\301\372M\353u\335T\352D\205G\001\364\206-\306\065\066M4&Zc\243%\215\036\071\022a0\270qƑ\v\212&9\344\002\303|\274\033\362O\352{Z\345\322\301ß\305\023\350\305\345*\264\065\302\375z\211\ny\030\222\b\377\vV\257\351\033\332屟:0\266v\306na:E\022>\303\363\324\335\330\345 _\375\222A\350\310@\361B\243Pǐ[\330}\276\277Y\240\061\302\313~\177U\r$\222\306n\245>H\302\001\374\f"...
        put = <optimized out>
        have = 1022863950
        left = 343
        hold = 59
        bits = 7
        in = 1022863961
        out = <optimized out>
        copy = <optimized out>
        from = <optimized out>
        here = <optimized out>
        len = <optimized out>
        ret = <optimized out>
        hbuf = "\247U\b\003"
        order = {16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15}
#2  0x0000000000559b7d in git_inflate (strm=0x7fffff7ff190, flush=4) at zlib.c:118
        status = 0
#3  0x000000000052d73d in unpack_compressed_entry (p=0x850ac0, w_curs=0x7fffff7ff8a8, curpos=50877863, size=342)
    at sha1_file.c:1933
        st = 0
        stream = {z = {
            next_in = 0x7fffb3b7e5a7 "x\234\235\216\261N\303\060\020\206w?\305-LHU\355\070\315\271\002\006\220P\a\220\220\212\330\317\366%\265\232ĕ{\251\bOOڑ\221\177\270\341t\337w\277\024f\360hLͨu\323\006\252\254\213\232\235\363\326qh=\326\301\372M\353u\335T\352D\205G\001\364\206-\306\065\066M4&Zc\243%\215\036\071\022a0\270qƑ\v\212&9\344\002\303|\274\033\362O\352{Z\345\322\301ß\305\023\350\305\345*\264\065\302\375z\211\ny\030\222\b\377\vV\257\351\033\332屟:0\266v\306na:E\022>\303\363\324\335\330\345 _\375\222A\350\310@\361B\243Pǐ[\330}\276\277Y\240\061\302\313~\177U\r"..., avail_in = 1022863961, total_in = 0, next_out = 0x178f040 "\034", avail_out = 343, total_out = 0, msg = 0x0, 
            state = 0x178f1a0, zalloc = 0x7ffff7bd3000 <zcalloc>, zfree = 0x7ffff7bd3010 <zcfree>, opaque = 0x0, 
            data_type = 0, adler = 1, reserved = 0}, avail_in = 1022863961, avail_out = 343, total_in = 0, 
          total_out = 0, 
          next_in = 0x7fffb3b7e5a7 "x\234\235\216\261N\303\060\020\206w?\305-LHU\355\070\315\271\002\006\220P\a\220\220\212\330\317\366%\265\232ĕ{\251\bOOڑ\221\177\270\341t\337w\277\024f\360hLͨu\323\006\252\254\213\232\235\363\326qh=\326\301\372M\353u\335T\352D\205G\001\364\206-\306\065\066M4&Zc\243%\215\036\071\022a0\270qƑ\v\212&9\344\002\303|\274\033\362O\352{Z\345\322\301ß\305\023\350\305\345*\264\065\302\375z\211\ny\030\222\b\377\vV\257\351\033\332屟:0\266v\306na:E\022>\303\363\324\335\330\345 _\375\222A\350\310@\361B\243Pǐ[\330}\276\277Y\240\061\302\313~\177U\r"..., next_out = 0x178f040 "\034"}
        buffer = 0x178f040 "\034"
        in = 0x7fffb3b7e5a7 "x\234\235\216\261N\303\060\020\206w?\305-LHU\355\070\315\271\002\006\220P\a\220\220\212\330\317\366%\265\232ĕ{\251\bOOڑ\221\177\270\341t\337w\277\024f\360hLͨu\323\006\252\254\213\232\235\363\326qh=\326\301\372M\353u\335T\352D\205G\001\364\206-\306\065\066M4&Zc\243%\215\036\071\022a0\270qƑ\v\212&9\344\002\303|\274\033\362O\352{Z\345\322\301ß\305\023\350\305\345*\264\065\302\375z\211\ny\030\222\b\377\vV\257\351\033\332屟:0\266v\306na:E\022>\303\363\324\335\330\345 _\375\222A\350\310@\361B\243Pǐ[\330}\276\277Y\240\061\302\313~\177U\r"...
#4  0x000000000052e1b7 in unpack_entry (p=0x850ac0, obj_offset=50877861, final_type=0x7fffff7ffb10, 
    final_size=0x7fffff7ffb08) at sha1_file.c:2206
        w_curs = 0x83e9a0
        curpos = 50877863
        data = 0x0
        size = 342
        type = OBJ_COMMIT
        small_delta_stack = {{obj_offset = 4345844982, curpos = 140737479964936, size = 140736208561400}, {
            obj_offset = 8645024, curpos = 140737479965088, size = 5432450}, {obj_offset = 140737479965544, 
            curpos = 140737479965552, size = 50877686}, {obj_offset = 8719040, curpos = 23623984, size = 0}, {
            obj_offset = 140737479965184, curpos = 140737479965032, size = 140737488348192}, {obj_offset = 8645024, 
            curpos = 140737479965184, size = 5432450}, {obj_offset = 140737479965640, curpos = 140737479965648, 
            size = 50877567}, {obj_offset = 8719040, curpos = 140736208561279, size = 343}, {obj_offset = 50877567, 
            curpos = 50877573, size = 127}, {obj_offset = 8645024, curpos = 140737479965280, size = 5432450}, {
            obj_offset = 140737479965736, curpos = 140737479965744, size = 50877376}, {obj_offset = 8719040, 
            curpos = 140736208561088, size = 24703030}, {obj_offset = 4345844450, curpos = 140737479965224, 
            size = 140736208560868}, {obj_offset = 8645024, curpos = 140737479965376, size = 5432450}, {
            obj_offset = 140737479965832, curpos = 140737479965840, size = 50877154}, {obj_offset = 8719040, 
            curpos = 140736208560866, size = 23620054}, {obj_offset = 4345844261, curpos = 140737479965320, 
            size = 140736208560679}, {obj_offset = 8645024, curpos = 140737479965472, size = 5432450}, {
            obj_offset = 140737479965928, curpos = 140737479965936, size = 50876965}, {obj_offset = 8719040, 
            curpos = 140736208560677, size = 24703061}, {obj_offset = 4345844003, curpos = 140737479965416, 
            size = 140736208560421}, {obj_offset = 8645024, curpos = 140737479965568, size = 5432450}, {
            obj_offset = 140737479966024, curpos = 140737479966032, size = 50876707}, {obj_offset = 8719040, 
            curpos = 23619712, size = 0}, {obj_offset = 140737479965664, curpos = 140737479965512, 
            size = 140737488348192}, {obj_offset = 8645024, curpos = 140737479965664, size = 5432450}, {
            obj_offset = 140737479966120, curpos = 140737479966128, size = 50876591}, {obj_offset = 8719040, 
            curpos = 140736208560303, size = 333}, {obj_offset = 50876591, curpos = 50876595, size = 115}, {
            obj_offset = 8645024, curpos = 140737479965760, size = 5432450}, {obj_offset = 140737479966216, 
            curpos = 140737479966224, size = 50876385}, {obj_offset = 8719040, curpos = 140736208560097, 
            size = 24702629}, {obj_offset = 4345843495, curpos = 140737479965704, size = 140736208559913}, {
            obj_offset = 8645024, curpos = 140737479965856, size = 5432450}, {obj_offset = 140737479966312, 
            curpos = 140737479966320, size = 50876199}, {obj_offset = 8719040, curpos = 140736208559911, 
            size = 24702629}, {obj_offset = 4345843309, curpos = 140737479965800, size = 140736208559727}, {
            obj_offset = 8645024, curpos = 140737479965952, size = 5432450}, {obj_offset = 140737479966408, 
            curpos = 140737479966416, size = 50876013}, {obj_offset = 8719040, curpos = 140736208559725, 
            size = 24490578}, {obj_offset = 4345843162, curpos = 140737479965896, size = 140736208559580}, {
            obj_offset = 8645024, curpos = 140737479966048, size = 5432450}, {obj_offset = 140737479966504, 
            curpos = 140737479966512, size = 50875866}, {obj_offset = 8719040, curpos = 140736208559578, 
            size = 24490629}, {obj_offset = 4345842975, curpos = 140737479965992, size = 140736208559393}, {
            obj_offset = 8645024, curpos = 140737479966144, size = 5432450}, {obj_offset = 140737479966600, 
            curpos = 140737479966608, size = 50875679}, {obj_offset = 8719040, curpos = 24490448, size = 0}, {
            obj_offset = 140737479966240, curpos = 140737479966088, size = 140737488348192}, {obj_offset = 8645024, 
            curpos = 140737479966240, size = 5432450}, {obj_offset = 140737479966696, curpos = 140737479966704, 
            size = 50875558}, {obj_offset = 8719040, curpos = 140736208559270, size = 362}, {obj_offset = 50875558, 
            curpos = 50875564, size = 126}, {obj_offset = 8645024, curpos = 140737479966336, size = 5432450}, {
            obj_offset = 140737479966792, curpos = 140737479966800, size = 50875395}, {obj_offset = 8719040, 
            curpos = 140736208559107, size = 24702213}, {obj_offset = 4345842526, curpos = 140737479966280, 
            size = 140736208558944}, {obj_offset = 8645024, curpos = 140737479966432, size = 5432450}, {
            obj_offset = 140737479966888, curpos = 140737479966896, size = 50875230}, {obj_offset = 8719040, 
            curpos = 140736208558942, size = 24702206}, {obj_offset = 4345842359, curpos = 140737479966376, 
            size = 140736208558777}, {obj_offset = 8645024, curpos = 140737479966528, size = 5432450}, {
            obj_offset = 140737479966984, curpos = 140737479966992, size = 11913437198307314359}, {
            obj_offset = 8719040, curpos = 218518752100604599, size = 140737479964864}}
        delta_stack = 0x7fffff7ff290
        delta_stack_nr = 0
        delta_stack_alloc = 64
        base_from_cache = 0
#5  0x000000000052d971 in cache_or_unpack_entry (p=0x850ac0, base_offset=50877861, base_size=0x7fffff7ffb08, 
    type=0x7fffff7ffb10, keep_cache=1) at sha1_file.c:2011
        ent = 0x821cb0 <delta_base_cache+4592>
        ret = 0x1687930
#6  0x000000000052f000 in read_packed_sha1 (
    sha1=0x1773e14 "k\360\205\331\004\314\063\321\024\006\231'\031\260\067\266\336M\212j", type=0x7fffff7ffb10, 
    size=0x7fffff7ffb08) at sha1_file.c:2614
        e = {offset = 50877861, sha1 = "k\360\205\331\004\314\063\321\024\006\231'\031\260\067\266\336M\212j", 
          p = 0x850ac0}
        data = 0x1773e14
#7  0x000000000052f285 in read_object (
    sha1=0x1773e14 "k\360\205\331\004\314\063\321\024\006\231'\031\260\067\266\336M\212j", type=0x7fffff7ffb10, 
    size=0x7fffff7ffb08) at sha1_file.c:2662
        mapsize = 140737479965264
        map = 0x5295b6 <lookup_replace_object_extended+43>
        buf = 0x100000000
        co = 0x0
#8  0x000000000052f35d in read_sha1_file_extended (
    sha1=0x1773e14 "k\360\205\331\004\314\063\321\024\006\231'\031\260\067\266\336M\212j", type=0x7fffff7ffb10, 
    size=0x7fffff7ffb08, flag=1) at sha1_file.c:2690
        data = 0x0
        p = 0x7fffffffe420
        repl = 0x1773e14 "k\360\205\331\004\314\063\321\024\006\231'\031\260\067\266\336M\212j"
#9  0x000000000049ee7c in read_sha1_file (
    sha1=0x1773e14 "k\360\205\331\004\314\063\321\024\006\231'\031\260\067\266\336M\212j", type=0x7fffff7ffb10, 
    size=0x7fffff7ffb08) at cache.h:819
No locals.
#10 0x000000000049fb19 in parse_commit (item=0x1773e10) at commit.c:316
        type = 16
        buffer = 0x4043e0 <_start>
        size = 140737343325728
        ret = 0
#11 0x000000000045c9e7 in name_rev (commit=0x1773e10, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87265, distance=87265, deref=0) at builtin/name-rev.c:30
        name = 0x0
        parents = 0x1
        parent_number = 1
#12 0x000000000045cbed in name_rev (commit=0x1773dc8, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87264, distance=87264, deref=0) at builtin/name-rev.c:79
        name = 0x1687a70
        parents = 0x1687a50
        parent_number = 1
#13 0x000000000045cbed in name_rev (commit=0x1773d80, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87263, distance=87263, deref=0) at builtin/name-rev.c:79
        name = 0x1686900
        parents = 0x1687a90
        parent_number = 1
#14 0x000000000045cbed in name_rev (commit=0x1773d38, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87262, distance=87262, deref=0) at builtin/name-rev.c:79
        name = 0x16868e0
        parents = 0x16868c0
        parent_number = 1
#15 0x000000000045cbed in name_rev (commit=0x1773cf0, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87261, distance=87261, deref=0) at builtin/name-rev.c:79
        name = 0x16868a0
        parents = 0x175b220
        parent_number = 1
#16 0x000000000045cbed in name_rev (commit=0x1773ca8, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87260, distance=87260, deref=0) at builtin/name-rev.c:79
        name = 0x175b200
        parents = 0x16869e0
        parent_number = 1
#17 0x000000000045cbed in name_rev (commit=0x1773c60, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87259, distance=87259, deref=0) at builtin/name-rev.c:79
        name = 0x175b1e0
        parents = 0x175b1c0
        parent_number = 1
#18 0x000000000045cbed in name_rev (commit=0x1773c18, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87258, distance=87258, deref=0) at builtin/name-rev.c:79
        name = 0x1686880
        parents = 0x175b240
        parent_number = 1
#19 0x000000000045cbed in name_rev (commit=0x1773bd0, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87257, distance=87257, deref=0) at builtin/name-rev.c:79
        name = 0x175b1a0
        parents = 0x175b180
        parent_number = 1
#20 0x000000000045cbed in name_rev (commit=0x1773b88, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87256, distance=87256, deref=0) at builtin/name-rev.c:79
        name = 0x175b160
        parents = 0x175b330
        parent_number = 1
#21 0x000000000045cbed in name_rev (commit=0x1773b40, tip_name=0x87a240 "B2G_1_0_0_20130115070201", 
    generation=87255, distance=87255, deref=0) at builtin/name-rev.c:79
        name = 0x175b310
        parents = 0x175b2f0
        parent_number = 1


=================

Remove most of the name_rev calls.
See 
http://people.mozilla.org/~sledru/bt-git-on-ff.txt
for the full list
=================


#87275 0x000000000045cbed in name_rev (commit=0x85d828, tip_name=0x87a240 "B2G_1_0_0_20130115070201", generation=1, 
    distance=1, deref=0) at builtin/name-rev.c:79
        name = 0x87a290
        parents = 0x87a3c0
        parent_number = 1
#87276 0x000000000045cbed in name_rev (commit=0x85d7e0, tip_name=0x87a240 "B2G_1_0_0_20130115070201", generation=0, 
    distance=0, deref=0) at builtin/name-rev.c:79
        name = 0x87a270
        parents = 0x879df0
        parent_number = 1
#87277 0x000000000045cfca in name_ref (path=0x87a210 "B2G_1_0_0_20130115070201", 
    sha1=0x843ec8 "\f\337Bk\006\356n}\275\347\217\325ݛ\350\346\001.\324\006", flags=10, cb_data=0x7fffffffdda0)
    at builtin/name-rev.c:179
        commit = 0x85d7e0
        o = 0x85d7e0
        data = 0x7fffffffdda0
        can_abbreviate_output = 1
        deref = 0
#87278 0x0000000000508ffd in do_one_ref (entry=0x843ec0, cb_data=0x7fffffffd290) at refs.c:650
        data = 0x7fffffffd290
        old_current_ref = 0x0
        retval = 0
#87279 0x0000000000509387 in do_for_each_entry_in_dirs (dir1=0x843f28, dir2=0x83d888, fn=0x508f46 <do_one_ref>, 
    cb_data=0x7fffffffd290) at refs.c:748
        e = 0x843ec0
        e1 = 0x843ec0
        e2 = 0x84a600
        cmp = -1
        retval = 5
        i1 = 1
        i2 = 0
        __PRETTY_FUNCTION__ = "do_for_each_entry_in_dirs"
#87280 0x0000000000509299 in do_for_each_entry_in_dirs (dir1=0x83d948, dir2=0x83d6d8, fn=0x508f46 <do_one_ref>, 
    cb_data=0x7fffffffd290) at refs.c:720
        subdir1 = 0x843f28
        subdir2 = 0x83d888
        e1 = 0x843f20
        e2 = 0x83d880
        cmp = 0
        retval = 0
        i1 = 1
        i2 = 2
        __PRETTY_FUNCTION__ = "do_for_each_entry_in_dirs"
#87281 0x0000000000509299 in do_for_each_entry_in_dirs (dir1=0x83d658, dir2=0x83d698, fn=0x508f46 <do_one_ref>, 
    cb_data=0x7fffffffd290) at refs.c:720
        subdir1 = 0x83d948
        subdir2 = 0x83d6d8
        e1 = 0x83d940
        e2 = 0x83d6d0
        cmp = 0
        retval = 0
        i1 = 0
        i2 = 0
        __PRETTY_FUNCTION__ = "do_for_each_entry_in_dirs"
#87282 0x000000000050ad97 in do_for_each_entry (refs=0x816ea0 <ref_cache>, base=0x599616 "", 
    fn=0x508f46 <do_one_ref>, cb_data=0x7fffffffd290) at refs.c:1686
        packed_ref_cache = 0x83d1c0
        loose_dir = 0x83d698
        packed_dir = 0x83d658
        retval = 0
#87283 0x000000000050ae6c in do_for_each_ref (refs=0x816ea0 <ref_cache>, base=0x599616 "", fn=0x45ce44 <name_ref>, 
    trim=0, flags=0, cb_data=0x7fffffffdda0) at refs.c:1721
        data = {base = 0x599616 "", trim = 0, flags = 0, fn = 0x45ce44 <name_ref>, cb_data = 0x7fffffffdda0}
#87284 0x000000000050af92 in for_each_ref (fn=0x45ce44 <name_ref>, cb_data=0x7fffffffdda0) at refs.c:1754
No locals.
#87285 0x000000000045d930 in cmd_name_rev (argc=0, argv=0x83d4c8, prefix=0x0) at builtin/name-rev.c:383
        revs = {nr = 1, alloc = 64, objects = 0x848cb0}
        all = 0
        transform_stdin = 0
        allow_undefined = 0
        always = 0
        peel_tag = 1
        data = {tags_only = 1, name_only = 1, ref_filter = 0x0}
        opts = {{type = OPTION_SET_INT, short_name = 0, long_name = 0x57f171 "name-only", value = 0x7fffffffdda4, 
            argh = 0x0, help = 0x57f17b "print only names (no SHA-1)", flags = 2, callback = 0x0, defval = 1}, {
            type = OPTION_SET_INT, short_name = 0, long_name = 0x57f197 "tags", value = 0x7fffffffdda0, argh = 0x0, 
            help = 0x57f1a0 "only use tags to name the commits", flags = 2, callback = 0x0, defval = 1}, {
            type = OPTION_STRING, short_name = 0, long_name = 0x57f1c2 "refs", value = 0x7fffffffdda8, 
            argh = 0x57f1c7 "pattern", help = 0x57f1d0 "only use refs matching <pattern>", flags = 0, 
            callback = 0x0, defval = 0}, {type = OPTION_GROUP, short_name = 0, long_name = 0x0, value = 0x0, 
            argh = 0x0, help = 0x57f1f1 "", flags = 0, callback = 0x0, defval = 0}, {type = OPTION_SET_INT, 
            short_name = 0, long_name = 0x57f1f2 "all", value = 0x7fffffffddcc, argh = 0x0, 
            help = 0x57f1f8 "list all commits reachable from all refs", flags = 2, callback = 0x0, defval = 1}, {
            type = OPTION_SET_INT, short_name = 0, long_name = 0x57f221 "stdin", value = 0x7fffffffddc8, 
            argh = 0x0, help = 0x57f227 "read from stdin", flags = 2, callback = 0x0, defval = 1}, {
            type = OPTION_SET_INT, short_name = 0, long_name = 0x57f0ba "undefined", value = 0x7fffffffddc4, 
            argh = 0x0, help = 0x57f238 "allow to print `undefined` names (default)", flags = 2, callback = 0x0, 
            defval = 1}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x57f263 "always", 
            value = 0x7fffffffddc0, argh = 0x0, help = 0x57f270 "show abbreviated commit object as fallback", 
            flags = 2, callback = 0x0, defval = 1}, {type = OPTION_SET_INT, short_name = 0, 
            long_name = 0x57f29b "peel-tag", value = 0x7fffffffddbc, argh = 0x0, 
            help = 0x57f2a8 "dereference tags in the input (internal use)", flags = 10, callback = 0x0, 
            defval = 1}, {type = OPTION_END, short_name = 0, long_name = 0x0, value = 0x0, argh = 0x0, help = 0x0, 
            flags = 0, callback = 0x0, defval = 0}}
#87286 0x000000000042f6ec in cmd_describe (argc=1, argv=0x7fffffffe438, prefix=0x0) at builtin/describe.c:458
        args = {argv = 0x83d4c0, argc = 6, alloc = 24}
        contains = 1
        options = {{type = OPTION_SET_INT, short_name = 0, long_name = 0x574b1d "contains", value = 0x7fffffffe1a8, 
            argh = 0x0, help = 0x574b28 "find the tag that comes after the commit", flags = 2, callback = 0x0, 
            defval = 1}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x574b51 "debug", 
            value = 0x7e8320 <debug>, argh = 0x0, help = 0x574b58 "debug search strategy on stderr", flags = 2, 
            callback = 0x0, defval = 1}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x574b78 "all", 
            value = 0x7e8324 <all>, argh = 0x0, help = 0x574b7c "use any ref", flags = 2, callback = 0x0, 
            defval = 1}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x574b88 "tags", 
            value = 0x7e8328 <tags>, argh = 0x0, help = 0x574b8d "use any tag, even unannotated", flags = 2, 
            callback = 0x0, defval = 1}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x574bab "long", 
            value = 0x7e832c <longformat>, argh = 0x0, help = 0x574bb0 "always use long format", flags = 2, 
            callback = 0x0, defval = 1}, {type = OPTION_SET_INT, short_name = 0, 
            long_name = 0x574bc7 "first-parent", value = 0x7e8330 <first_parent>, argh = 0x0, 
            help = 0x574bd4 "only follow first parent", flags = 2, callback = 0x0, defval = 1}, {
            type = OPTION_CALLBACK, short_name = 0, long_name = 0x574bed "abbrev", value = 0x7dd560 <abbrev>, 
            argh = 0x574bf4 "n", help = 0x574bf8 "use <n> digits to display SHA-1s", flags = 1, 
            callback = 0x4f706c <parse_opt_abbrev_cb>, defval = 0}, {type = OPTION_SET_INT, short_name = 0, 
            long_name = 0x574c19 "exact-match", value = 0x7dd564 <max_candidates>, argh = 0x0, 
            help = 0x574c25 "only output exact matches", flags = 2, callback = 0x0, defval = 0}, {
            type = OPTION_INTEGER, short_name = 0, long_name = 0x574c3f "candidates", 
            value = 0x7dd564 <max_candidates>, argh = 0x574bf4 "n", 
            help = 0x574c50 "consider <n> most recent tags (default: 10)", flags = 0, callback = 0x0, defval = 0}, {
            type = OPTION_STRING, short_name = 0, long_name = 0x574c7c "match", value = 0x7e8368 <pattern>, 
            argh = 0x574c82 "pattern", help = 0x574c90 "only consider tags matching <pattern>", flags = 0, 
            callback = 0x0, defval = 0}, {type = OPTION_SET_INT, short_name = 0, long_name = 0x574cb6 "always", 
            value = 0x7e8370 <always>, argh = 0x0, help = 0x574cc0 "show abbreviated commit object as fallback", 
            flags = 2, callback = 0x0, defval = 1}, {type = OPTION_STRING, short_name = 0, 
            long_name = 0x574ceb "dirty", value = 0x7e8378 <dirty>, argh = 0x574cf1 "mark", 
            help = 0x574cf8 "append <mark> on dirty working tree (default: \"-dirty\")", flags = 1, callback = 0x0, 
            defval = 5721392}, {type = OPTION_END, short_name = 0, long_name = 0x0, value = 0x0, argh = 0x0, 
            help = 0x0, flags = 0, callback = 0x0, defval = 0}}
#87287 0x000000000040528a in run_builtin (p=0x7dab78 <commands+600>, argc=3, argv=0x7fffffffe430) at git.c:314
        status = 980314466
        help = 0
        st = {st_dev = 0, st_ino = 0, st_nlink = 140737488347856, st_mode = 4158565948, st_uid = 32767, st_gid = 1, 
          __pad0 = 0, st_rdev = 0, st_size = 140737488347856, st_blksize = 140737339576408, st_blocks = 0, 
          st_atim = {tv_sec = 140737488347856, tv_nsec = 4211680}, st_mtim = {tv_sec = 140737351979637, 
            tv_nsec = 140737488348907}, st_ctim = {tv_sec = 8638752, tv_nsec = 140737488348208}, __unused = {
            5676260, 140737488348907, 1}}
        prefix = 0x0
#87288 0x0000000000405483 in handle_builtin (argc=3, argv=0x7fffffffe430) at git.c:487
        p = 0x7dab78 <commands+600>
        cmd = 0x7fffffffe6e2 "describe"
        i = 25
        ext = ""
#87289 0x000000000040559d in run_argv (argcp=0x7fffffffe31c, argv=0x7fffffffe320) at git.c:533
        done_alias = 0
#87290 0x0000000000405739 in main (argc=3, av=0x7fffffffe428) at git.c:616
        done_help = 0
        was_alias = 0
        argv = 0x7fffffffe430
        cmd = 0x7fffffffe6e2 "describe"

--------------080105090102060000080504--
