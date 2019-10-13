Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3591B1F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 11:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbfJMLum (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 07:50:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24942 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728620AbfJMLum (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 07:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570967438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=jwIVhn7B7+/sdNSt+JED8k53Detn01zp3Fb75DKvVZ8=;
        b=Ht749xNQ3sft3WIxHr0vTRd2yqS0YUbwAPm893TVvJGyciB9jYUhu77wBPTodm6kj6FHNj
        JT1Q1PAEVGnEjbPcX/ncAoP9U8Gg2UiFT337R9KGNrAV8k94ituIx88oq52END7GSGgUzx
        17WGORo9XJnJTFQRwbpEqpLhfsUQSPA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-300-bOBaKabRMru5sFMAC5FRHQ-1; Sun, 13 Oct 2019 07:50:37 -0400
Received: by mail-qt1-f199.google.com with SMTP id h10so14873868qtq.11
        for <git@vger.kernel.org>; Sun, 13 Oct 2019 04:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=d9qrqIySwO4Dr3OPbkACWRxMSs3dXW+wyqqY72ngh5g=;
        b=k3a/wbqtr0QVMUhts+Ih1fchHkYJeY+2XIMmPyLeIK3d+1OzQ0k7zHR7bzGlCve9Sk
         XOhiExhe9Tt1uPtEOfvWspEh7C3LCjsv16bauYqC8YH6TiM19rxCLZJqgxG7URN53y7A
         owEev2HG/1eOTVgqCeyfx4H7zODqe1CzhuR2KRu7yajMZDQplLPw09YbP4GqldRPMIBI
         7+W0AqD4DzOGfaSkKCgEWE+0GM4+hZvV4zDtU63Gj1MLRZecq06lCSl1G2DP756Pu0sU
         yK8GmRf0AGY1+LDp05wwF9USoPn513vJkwRP0rWNN11n6EWbg5k6tX9uFr0pOGZ2MEAK
         1pEw==
X-Gm-Message-State: APjAAAUa2X9z8yqa4hYMeOgC5c4kloOyuK5JPO83ovdsaJLMXe/rWmaM
        Kqzo//4QxLzCQjNPcAsL5s7E+XNvQvKzVuV8D4SPlbplihkyQhONxz6OZFgjQR3Chjw/jm5OeFK
        LKY9hDBcM7WF4
X-Received: by 2002:a05:6214:4d:: with SMTP id c13mr25553567qvr.116.1570967436555;
        Sun, 13 Oct 2019 04:50:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySwhR8nAO23UQ7aXK/uAHDChOA4iG95o8KJZqGK2OEvp0erJvmpPz5ofgHJF5ebrz3/qab6g==
X-Received: by 2002:a05:6214:4d:: with SMTP id c13mr25553554qvr.116.1570967436247;
        Sun, 13 Oct 2019 04:50:36 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
        by smtp.gmail.com with ESMTPSA id 29sm7114585qkp.86.2019.10.13.04.50.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 04:50:35 -0700 (PDT)
Date:   Sun, 13 Oct 2019 07:50:32 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     git@vger.kernel.org
Subject: [PATCH] contrib: git-cpcover: copy cover letter
Message-ID: <20191013115006.4650-1-mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: bOBaKabRMru5sFMAC5FRHQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My flow looks like this:
1. git format-patch -v<n> --cover-letter <params> -o <dir>
2. vi <dir>/v<n-1>-0000-cover-letter.patch <dir>/v<n>-0000-cover-letter.pat=
ch

copy subject and blurb, avoiding patchset stats

3. add changelog update blurb as appropriate

4. git send-email <dir>/v<n>-*

The following perl script automates step 2 above.  Hacked together
rather quickly, so I'm only proposing it for contrib for now.  If others
see the need, we can add docs, tests and move it to git proper.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/git-cpcover | 80 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)
 create mode 100755 contrib/git-cpcover

diff --git a/contrib/git-cpcover b/contrib/git-cpcover
new file mode 100755
index 0000000000..d80bd141ba
--- /dev/null
+++ b/contrib/git-cpcover
@@ -0,0 +1,80 @@
+#!/usr/bin/perl -i
+
+use strict;
+
+die "Usage: ${0} <from> [<to>]" unless $#ARGV =3D=3D 0 or $#ARGV =3D=3D 1;
+
+my $ffrom =3D shift @ARGV;
+my @extraheaders =3D ();
+
+open(FROM, "<", $ffrom) || die "Can not open $ffrom";
+
+my @from =3D ();
+while (<FROM>) {
+=09push @from, $_;
+}
+
+close(FROM) || die "error closing $ffrom";
+
+#get subject
+my $subj;
+my $bodyi;
+for (my $i =3D 0; $i <=3D $#from; $i++) {
+=09$_ =3D $from[$i];
+=09#print STDERR "<$line>\n";
+=09if (not defined ($subj) and s/^Subject: \[[^]]+\] //) {
+=09=09$subj =3D $_;
+=09=09chomp $subj;
+=09}
+=09if (m/^(To|Cc):/) {
+=09=09push @extraheaders, $from[$i];
+=09}
+=09if (defined ($subj) and m/^$/) {
+=09=09$bodyi =3D $i + 1;
+=09=09last;
+=09}
+}
+
+die "No subject found in $ffrom" unless defined($subj);
+
+die "No body found in $ffrom" unless defined($bodyi);
+
+my $bodyl;
+my $statb;
+my $state;
+for (my $i =3D $#from; $i >=3D $bodyi; $i--) {
+=09$_ =3D $from[$i];
+=09$statb =3D $i if m/ [0-9]+ files changed, [0-9]+ insertions\(\+\), [0-9=
]+ deletions\(-\)/;
+=09next unless defined($statb);
+=09$state =3D $i if m/^$/;
+=09next unless defined($state);
+=09next if m/^$/;
+=09next if m/^  [^ ]/;
+=09next if m/\([0-9]+\):$/;
+=09$bodyl =3D $i;
+=09last;
+}
+
+die "No body found in $ffrom" unless defined($bodyl);
+
+#print STDERR $bodyi, "-", $bodyl, "\n";
+my $blurb =3D join("", @from[$bodyi..$bodyl]);
+
+my $gotsubj =3D 0;
+my $gotblurb =3D 0;
+my $gotendofheaders =3D 0;
+while (<>) {
+=09if (not $gotsubj and
+=09    s/\*\*\* SUBJECT HERE \*\*\*/$subj/) {
+=09=09$gotsubj =3D 1;
+=09}
+=09if (not $gotblurb and
+=09    s/\*\*\* BLURB HERE \*\*\*/$blurb/) {
+=09=09$gotblurb =3D 1;
+=09}
+=09if (not $gotendofheaders and m/^$/) {
+=09=09print join("", @extraheaders);
+=09=09$gotendofheaders =3D 1;
+=09}
+=09print $_;
+}
--=20
MST

