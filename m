Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBEB38C2B8
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069448; cv=none; b=jQXExb1MHgkqIY/gbymnhMbPQmXTtDZJEzYprLIU8wBOo3mXUggPM7AZSAPseEzpiP9hgzF5xKhp/4cuFCn2UA7H+AMHLGw6UsVY0vYsn7/VPNi0sEeKh2l2jpGhvQX7avJlFH3Wr1MpSOl79diFkT2q4gfxjfhMo1gehKV1JUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069448; c=relaxed/simple;
	bh=72BRD7nvb97Fpeuv8uX/8ZRcRJQqjGmmSOIBg+JC1pY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axXxByUHyYBVXK18OK+5FmZ3Qkrjowxh7poTrD1sW1R3Vsn5mQ+SFG4h+Fs3bkxc7GVPkxPYqQQ0YD/fT+RHAN9X0gb+aRpPHES2SjZZlI8fA9B8snAG4k/W2+jkUZtH1XYsQzzQL09Cu3QpsrnLUAY8rjvSMaTIb6jICPAWebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=HLCvlbPX; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="HLCvlbPX"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68AJhvdr016442-68AJhvdt016442
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 10 Sep 2026 22:43:57 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x4kgf-001yaQ-Jc;
	Thu, 10 Sep 2026 22:43:57 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 10 Sep
 2026 22:43:57 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 98bab926;
	Thu, 10 Sep 2026 19:43:56 +0000 (UTC)
From: Tuomas Ahola <taahol@utu.fi>
To: <git@vger.kernel.org>
CC: Junio C Hamano <gitster@pobox.com>, Tuomas Ahola <taahol@utu.fi>
Subject: [PATCH v2 0/2] guides: keep Documentation/Makefile and command-list.txt in sync
Date: Thu, 10 Sep 2026 22:43:49 +0300
Message-ID: <20260910194351.20809-1-taahol@utu.fi>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260909052501.8448-1-taahol@utu.fi>
References: <20260909052501.8448-1-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIWkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:references:mime-version:content-type;
 bh=chFLJ+rqtA8VP/m7Piymn7Fhn6hvI/vB3qkdRFVxd4s=;
 b=HLCvlbPXr5lb+xV/145GbgaynLhRYARyQ9R7+siK/16Nw7sbi+Xrt/mFymQ+6QzgddsEvMjTXDKO
	sXjyM+mC0QMCZ1HlKnV7luVmCn5P7L2ZsT41YulFxXAcN7ZYKg8zsnHshPxd2SJgdxgfNTQWi3Ub
	LiTz6KnUK4yNvOe3L1XQSTXTUVtisGAbS12i1MfjD32biwUg2Pl+qipVlQvWheoGio13eYxhVh1z
	oj4m2Hm+jiAPm03dL4nLzJHx1962QE65vPsxHlgxq/eKa0mP4QbXUXs3U6A1uik9LxMV2sfvL0Zy
	eKo5Q3pdrE6eHPJqO3Bip5zHuS7SrzGN7N/gUw==

Documentation/lint-manpages.sh was expanded with a new test
ensuring that command-list.txt also includes all non-command
manual pages (concept guides and interface manuals).

Based on kh/doc-datamodel.

Changes in v2:

* [1/2]: Use command-list.txt as the area identifier.
* [2/2]: Protect variables againtst whitespace breakage per review comment.

Tuomas Ahola (2):
  command-list.txt: add gitformat-loose(5) and gitpacking(7)
  lint-docs: check the guide list in command-list.txt

 Documentation/Makefile         |  2 ++
 Documentation/lint-manpages.sh | 10 +++++++---
 command-list.txt               |  2 ++
 3 files changed, 11 insertions(+), 3 deletions(-)

Intervall-diff mot v1:
1:  014da7fdff ! 1:  cb6ce6cad1 command-list: add gitformat-loose(5) and gitpacking(7)
    @@ Metadata
     Author: Tuomas Ahola <taahol@utu.fi>
     
      ## Commit message ##
    -    command-list: add gitformat-loose(5) and gitpacking(7)
    +    command-list.txt: add gitformat-loose(5) and gitpacking(7)
     
         Three manpages from sections 5 and 7 are not featured in
         command-list.txt as concept guides or interface manuals.
2:  b24d96f732 ! 2:  2dc1ee4514 lint-docs: check the guide list in command-list.txt
    @@ Documentation/lint-manpages.sh
      
      extract_variable () {
     +	file=${2:-../Makefile}
    ++	directory=$(dirname "$file")
      	(
     -		cat ../Makefile
    -+		cat $file
    ++		cat "$file"
      		cat <<EOF
      print_variable:
      	@\$(foreach b,\$($1),echo XXX \$(b:\$X=) YYY;)
      EOF
      	) |
     -	make -C .. -f - print_variable 2>/dev/null |
    -+	make -C $(dirname $file) -f - print_variable 2>/dev/null |
    ++	make -C "$directory" -f - print_variable 2>/dev/null |
      	sed -n -e 's/.*XXX \(.*\) YYY.*/\1/p'
      }
      

base-commit: b8242b093d9e941a34460d715e3ce616a34ac3fe
-- 
ta/command-list-guides-sync-lint

