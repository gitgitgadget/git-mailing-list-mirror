Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD841C8610
	for <git@vger.kernel.org>; Tue,  1 Apr 2025 03:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743476497; cv=none; b=PlVMSBuyrNy3jfnx0vAGM5m1Ykfhs7Br5ihjGXZ4EX4bQLgSVeszZZRJp1vhgJgmb7VHpulOY/DmgarI6xnHxsM7HplweHvT/jHp02/hLQBXD61GvzNNPVE4hze+CdKIb2WUDQu+eRuLv1W/QUmrzWOJBYIOysRcDLFgJnhboC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743476497; c=relaxed/simple;
	bh=MOTiBElZ2MCvH1otKx2fCwxdiIJa/Vts+MgArbwOask=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXk9LnbxrqWGXphF9MSPVt+WWvEdc+NMulvD7lDi13ATailf3iNSvfzZTa2Oi8cWmylChjIUhZ+S+UW2UaAN6AN3yi0T66ezAzf4B+KD7O+XkSccAmq+WbhtOcMZ+uswY6TqEJ2p0qc/BHRhrzzDAVPOfcZV1uZd2bBMlwlSgAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhyBuXSn; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhyBuXSn"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e904f53151so44235716d6.3
        for <git@vger.kernel.org>; Mon, 31 Mar 2025 20:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743476495; x=1744081295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09niCTOK3OfvtYf3f9+RQQ5lWTdYJfS/Il25lNrsT+s=;
        b=lhyBuXSnn/DsRYM78R5YPYmjJEn2J2nU6s3QxNe21LDLJffk+vka++OSD4pZLcFqKQ
         VKl03ZvWSVAMpKGp2i4U/OAMkYMIIMfc7HhcEWEYy76BfK1JzF8hgfwRYxtIw3o/kRE8
         m2BUtpeMj+ilXKIpU1uetwuyuYxEzvs2a4RMI82rRDOxEaj9Roch9ZSiCElBzw7bGWM4
         z+9oFLr7nhtYlq+ZHoa6sWgAHXtRw7YC2zgncZobZyrbq1ABy1+kc/a0kZ/j3PomwCOG
         ojGb2uH57qE+q9Kptny5w9x+81waL9/tIPp/Qk1zJzLP29Itzj5e+CzsyAxakmiBTrnn
         4eew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743476495; x=1744081295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09niCTOK3OfvtYf3f9+RQQ5lWTdYJfS/Il25lNrsT+s=;
        b=kLXwAC8oXwFYz6tZs2AjhlNJppmF+KuwiI9HnesKpU175ca+J3+Rs4KUkYcwkjPmcG
         JpyWQyix9wmpTIepv8cfMR+rwnnaDSyMF3Xoa+NkyAhy5FPJKkV9jDVepnwDqZ+QnqKK
         zrQRu+yZ41h7LRjt0//M7Vi5DD/5xGNtdyfcb4gL6T6HrJFR04Oc16ffhKm4gYbmhu5H
         KxJa4yskSf2xyCrYPNFZlgH/1lWroX/iflG08dtHqFXozZQmj8f30v6gHdQiaaOi6QOR
         pWkZVK+ivTkkKYFEkABosqiyjEc3blCJ4c6Xg+mV6CwvI5WuUyuEunqhyl8XUnd1EMD5
         Jy2w==
X-Gm-Message-State: AOJu0YzteXYMpawyHkoa2+E3KKpBD5WJsGnuhN74vv0mmCwr+9l5OPVu
	WJD+1cRAN16GRCxTJytSyKaNAzLea4PKkao2PNciIBysum1Amd8g
X-Gm-Gg: ASbGncsQty3YMz2+Bh0VJNDNMlLlzY5at6CLtmgU5KT+t2+nGrYPD0vgtA/3o13cefA
	tsLbLLqaizQiwTyyBwv/roD0H2aRpyzU+GNFXj+Kt7Dizm6LTD7UuS5v6RnNkDsW8mUF7yK+tAC
	lZ818NWDJuxvffgYoPjHdxClQ6/wQeyIiaQNF0YZUL8WSqNzqRCpA+fBVkT5j9/GXElpoP9CPVz
	LVeNfng+ADaQH40zhZSjZ4MGCznpihNkk4q1KI77MQKIeugcjvekWKnKWp9cRiRszPrpdAp2fKE
	F5NvR//+HtZjwtHd4m9089PHhCYc
X-Google-Smtp-Source: AGHT+IGpF5bjvWAWJ0wOtZOuXJr6MQEF2YIYJyHjsAVzH9uFlgK4kovBgPUTpB7iHHaW+8W1mwexZw==
X-Received: by 2002:a05:6214:1256:b0:6e6:68e3:8d84 with SMTP id 6a1803df08f44-6eed5fe38ddmr225939726d6.18.1743476494080;
        Mon, 31 Mar 2025 20:01:34 -0700 (PDT)
Received: from markl5i.lan ([2600:4040:2644:5100::387])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec96284d7sm55209556d6.1.2025.03.31.20.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 20:01:33 -0700 (PDT)
From: Mark Levedahl <mlevedahl@gmail.com>
To: j6t@kdbg.org,
	johannes.schindelin@gmx.de
Cc: git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH v2 3/3] gitk: limit PATH search to bare executable names
Date: Mon, 31 Mar 2025 23:01:02 -0400
Message-ID: <20250401030102.297272-4-mlevedahl@gmail.com>
X-Mailer: git-send-email 2.49.0.99.31
In-Reply-To: <20250401030102.297272-1-mlevedahl@gmail.com>
References: <5b09f1c2-be58-43a2-9908-7243b5207251@gmail.com>
 <20250401030102.297272-1-mlevedahl@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The path search overrides used by gitk on Windows are applied to any
executable whose name is not 'absolute', meaning that
	[exec foo/bar ...]
will search each element of $PATH to find one with subdirectory foo
containing bar. But, per POSIX, and Tcl implementation on all platforms,
foo/bar is taken as $(pwd)/foo/bar, and is not searched on $PATH.

Fix this descrepency using the same approach applied to git-gui in
commit 3f71c97e. The key is that the executable name must have no path
component, indicated by [file split $exename] having array length 1.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk b/gitk
index e4d0500..e38e071 100755
--- a/gitk
+++ b/gitk
@@ -58,7 +58,7 @@ if {[is_Windows]} {
 		set i $from_index
 		while {$i < [llength $command_line]} {
 			set cmd [lindex $command_line $i]
-			if {[file pathtype $cmd] ne "absolute"} {
+			if {[llength [file split $cmd]] < 2} {
 				set fullpath [_which $cmd]
 				if {$fullpath eq ""} {
 					throw {NOT-FOUND} "$cmd not found in PATH"
-- 
2.49.0.99.31

