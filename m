Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AD728DC4
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 00:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767313669; cv=none; b=BVIW3EbBJIKAmB0sE6+8ZW1vYu4RLYrSoXTVUBFUFxWUlTJvhx1XM9Vw7b95RoomvtSWg78fYbqC/2LjubtVSpVqQmOcOgWcCd/mOshzdYyFxUudC5b6ROJsFLROj+8dzYIY70U1foXOS1nPblYmTFBLLUCfU4BEbsUSq5Es1CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767313669; c=relaxed/simple;
	bh=3Inoe4Fi81E3UTafc6eJd2IOmh+tgtUxRPZkfqP536s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njyETlb1hHcUDfuhc+PmSVCmoQPPoCvVIVWkc5Qm69kyg3GDdkyxrqMs1mxYSlkb4WYImyCVojPDvOiKbXCGmcaFlJZXU8JFq+uchmPPPYApt1PX+5+g8syOF/wPacblPJDdaKLzQq/EAZDuvBIuIQib95DZgmfr94Nf7PLVTec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cU+rxe7+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cU+rxe7+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47796a837c7so74953185e9.0
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 16:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767313666; x=1767918466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cGCKBP2Wg8BaV3sb1yOT7FkYS5Cw9Sv72de7BXzZvc0=;
        b=cU+rxe7+oQUwRgR6j7RELthhur36IqnouMeUfZbv0mf8LWNam4ppoTZsv5gSvoefxL
         FuvbdjlC5wRf9n4nMebPR2S6q9lYJC2JGqSZMP/vzUzx5NlVTYzZ7HQ+9DAQMLPY/gFY
         q9gq9lY7b9HRH/1jLUUTcLLN5UBPx7ZD22sbkN+2hWOVBD/kOkFE/ZR6H5RDml6OqZCh
         6U7S/5bmMv61IXWFrQHFMmiZaMQjvpa8ZWp0l9JmV1GopWUOHSFMq1bhpjeObnxqO6l5
         8ZxUbjuU2mJZvaKnzw1ad7I4136WxcdAXivaEQrlNPUbqc4tIDOm03weIgD067YxCcPj
         91JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767313666; x=1767918466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGCKBP2Wg8BaV3sb1yOT7FkYS5Cw9Sv72de7BXzZvc0=;
        b=ikFMDpXwnBPb9H1TO1yMDU3Hf1FVkYB245LTjWG9fTopgQdIMNc373n4eguJ4Phto7
         6Ifh2vY3ihBdS3nns62mGraXAzjo2874LRC8DPKfjz0+mDLYrP/T+UEN5VtQIByfYQTl
         Kz2d+N9XxXcwggupbktOLsPWA5q7wInF6wM7/anfXhmGfXhyrYZYIw0Teqta+jx3+xSF
         uTfEcv5vTw4Nsexq0Ea0mzO2SSwsXI5ftnhteF95hquJ7DU3KQ7rdF/eLGSc1MkESfZt
         3egnmu8UndiY+Faw08V9UlDIQmm34v6D13dOriGDJ+jcwycKVjHZYiYZPwYZesgJTV+x
         6VXg==
X-Gm-Message-State: AOJu0YxQJFrhKpwJF5RJFmiVW01wGwsXCaV1Vm+RTNKZ++JedQaPLX7f
	3jhqZkGkQne3KoXTVpSOgvxyIFjQxzBr6u8IpPWqjCgBvTTcqKLM+m2Mpi6tQ/lp
X-Gm-Gg: AY/fxX6a06g2X0rhs1UThuZF6dm8sy9e9IbrLBH2fw7G6Nf4t5gJiOHn4DztyRoqdLs
	GcQ7H+y5qF0w6Fy7LrueJYXWZS6ner1YIfWXbTI7yPHI2Pu4EDipLdHUc9wvv53bHPP5I/Bf2Hq
	StJ1o7o/Gp7J+U87Kco50G4RIzo1Z/yxl/v80MvHjcMQcbdkiSCJ+HHgPBh3r54k8FgCwXTZ495
	Cu/uA1C7NJv6EBajEggjxOyWpTV8xD/1jKn7GFnngmvTdm4rRFPBn2kR/1rkJF2ww+EQS2Ok+bJ
	l4CUVR8Pjn94X3C2BkSGa0GHXRWtaT7QujbDo4g6xSpTze7HUp1lFcAft4feA7GwD6HBaFmfxc9
	FCEyHxkEA3mpqW6XA318A97NS6b/GG6W/ATdLyiF0DHRoqGqzi5sr7vC6ZC7zgQSLItImDHeISm
	aF6CiDuuQzZXM=
X-Google-Smtp-Source: AGHT+IG+/ot+r42BX8nsv/YpVhRBulAGFbOEU3UIdj6vseHFYOP3ynsmkwLK06Y6QL5yQLGAiASDNQ==
X-Received: by 2002:a05:600c:474d:b0:477:97ca:b727 with SMTP id 5b1f17b1804b1-47d1957d7e6mr458012545e9.19.1767313665657;
        Thu, 01 Jan 2026 16:27:45 -0800 (PST)
Received: from fedora.lan ([2a0d:6fc1:2:c000:95b3:4a19:75dc:a979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19362345sm715700585e9.6.2026.01.01.16.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jan 2026 16:27:45 -0800 (PST)
From: Rostislav Krasny <rostiprodev@gmail.com>
To: git@vger.kernel.org
Cc: Rostislav Krasny <rostiprodev@gmail.com>
Subject: [PATCH 0/1] compat: modernize and simplify byte swapping functions
Date: Fri,  2 Jan 2026 02:27:34 +0200
Message-ID: <20260102002735.31390-1-rostiprodev@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When I read sha256/block/sha256.c I noticed it uses both the htonl macro and
the get_be32() static inline function. I was surprised how different the
implementations of those two kindred things are. When GCC or Clang is used the
htonl macro is translated into the __builtin_bswap32() call, which is assembled
into one single CPU instruction, in the case of x86. And the original
implementation of the get_be32() function used eight bitwise operations. Even
if the compiler can optimize that code it's still less readable and more error
prone.

The main reason it was implemented so complicated is UB when conversion of a
pointer to one object type into a pointer of a different object type is used.
On the other hand, memcpy is protected from such UB and this allows us to make
that code simpler and even more optimal, in some cases.

Additionally I made a few more small improvements related to the same
functionality.

I've measured performance of the original and the new code on my Intel
Xeon W-2135 based computer in Fedora 43 Linux with:

* glibc 2.42-5.fc43
* gcc   15.2.1-5.fc43
* clang 21.1.7-1.fc43

I used the following code for these measurements:

#include <inttypes.h>
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <time.h>

#include "bswap.h"

#define ITERATIONS 1000000
#define BUF_SIZE 8192

int main() {
    uint8_t buffer[BUF_SIZE];
    uint64_t sum = 0;

    for (int i = 0; i < BUF_SIZE; i++) {
        buffer[i] = (uint8_t)i;
    }

    clock_t start = clock();

    for (int i = 0; i < ITERATIONS; i++) {
        // use a volatile pointer to force the compiler to read memory
        volatile uint8_t *p = buffer; 
        for (int j = 0; j < BUF_SIZE - 8; j++) {
            sum += get_be64((const void*)(p + j));
        }
    }
    
    clock_t end = clock();
    double time_taken = (double)(end - start) / CLOCKS_PER_SEC;

    printf("Time taken: %f seconds\n", time_taken);
    printf("Checksum: %" PRIu64 "\n", sum);

    return 0;
}

And these are the results:

GCC 15.2.1
version |  -Os     |  -O0     |  -O1     |  -O2     |  -O3
================================================================
        | 3.721806 |72.342204 |11.956021 | 3.119833 | 0.919873  
original| 3.726111 |72.326920 |11.963618 | 3.128222 | 0.921128  
        | 3.719791 |72.328175 |11.949108 | 3.130956 | 0.920296         
================================================================
        | 3.719899 |17.177719 | 3.005065 | 3.120747 | 0.920609  
new     | 3.714785 |17.168950 | 3.004978 | 3.119227 | 0.918851  
        | 3.716782 |17.145386 | 3.009364 | 3.119573 | 0.920030  
================================================================

Clang 21.1.7
version |  -Os     |  -O0     |  -O1     |  -O2     |  -O3
================================================================
        | 3.690718 |62.916338 | 3.017460 | 3.768443 | 3.778840  
original| 3.686283 |62.965916 | 3.014674 | 3.777897 | 3.774776  
        | 3.687775 |62.850648 | 3.003496 | 3.766108 | 3.765313         
================================================================
        | 3.681818 |16.753385 | 3.008131 | 2.075271 | 2.076090  
new     | 3.687184 |16.737982 | 3.004365 | 2.071597 | 2.074507  
        | 3.683960 |16.765067 | 2.999775 | 2.075354 | 2.075759  
================================================================

Rostislav Krasny (1):
  compat: modernize and simplify byte swapping functions

 compat/bswap.h | 74 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 30 deletions(-)

-- 
2.52.0

