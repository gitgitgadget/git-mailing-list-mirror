Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF123264EE
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411606; cv=none; b=rSJ0WiZv8BjfpuSuxqa06pyVkGfrPoirsWa8WNv3MYFLPEgUDV7V82Sb4k5yD9rfx5n7GV8S2uoQlSUSkFqz4dCKEB0YhkJ83p+veVcPc0rAZTz5ri4+hKfGnJYy+THHinkcmE1cFTQd52KhZ7fPY2wL3EoGAeC+r6uDy73zEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411606; c=relaxed/simple;
	bh=Ew1mIwZAUt62FY3XjvELGdmptTw4D3bkGWsK+2gxk7U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=svWRdv3Ut8ieR0GtMRZZLpSXo1JB5OUbp5qzdkj+nJtEdJgQVI6Im1rm7WhNleH75DuAvnjAhGou72ba2mkFTNlT8Mphr/GEly9bkR4O2yUq7r+LoJDet7F8CmXtEqOAHT6wXL90bSxm3hrmtbSgQ9+wpFLiRwy/9bunmcaapCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRNO9VDi; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRNO9VDi"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-439c9bdc1eeso2229447f8f.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411603; x=1774016403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mBRMCDwP2l/N5PQF5WV++kuThDOKzB/CYv3aYHEzTmg=;
        b=LRNO9VDiRYAuVU1bbC05ABbGDQKbVTrswvCfgotYgv6g09TPJP/7lmfjQUvTRkDyM4
         cADkO6z5fVg5xiB32NhijE5iMu8f+cRznDpR7xuf/Hiozx/+IjYk2zERV+9PhrzxjK7x
         HjeM8gAwfkGQDrEegpC70YwYG77QgH+2XUc/EM8xxJeaoYv2HnEO7SIGfmj7blFjZR8y
         s+fI40veDW7LAO+wg3aRCGIX9eUnXr2nesc0bZX9fAVcPfsO2tOINMLO6mLar6GfIYAq
         V0UHvP6nKhmRebhwE8ctbqDji6F696vspDgHMoD8cW4KAjfXaU/VMs3gz09JXK49wSC2
         De8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411603; x=1774016403;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBRMCDwP2l/N5PQF5WV++kuThDOKzB/CYv3aYHEzTmg=;
        b=H1/SbLzmrSgWX5B6BHAjFe/OzSei0Yz79wIwrgAebv1BSqE+VTNnxby0Q/ER6fTeUB
         nzB+oz243ZPCAh23OJH9Q7r4FBKMU8ouYJ7qxH7l31cUrNQBPCU6ZdgCt6rd10QF0BiD
         W8m/BzhQkyqEHzesjsIoKUVgSbtaAs8ZFn3qHv11bsgAa7zg1ODjWgjKfdTelT6J6YH2
         JEdViDbkd/JjwgJUfo997f9HUeLFNztUxqlfiKIC9j5wXk+iC92cwfPW5EHSLi2Dv/ec
         spjSe306TNFNAbIDQaHq5k1AGhwn+7750NSSvZ27uHW3LDO6vTUQBkcO7CImJdNORasb
         XazQ==
X-Gm-Message-State: AOJu0YwofWRJ4SDRxGX07QcWQF74FbZy3cXkY5nh2SVslYR6D/2IjEqz
	7+ARrNUj6A4fyU9MAIVRHqa4dnEVmphbks+Ndo7v6ya7xeKHO3xr4fHCih6Kkg==
X-Gm-Gg: ATEYQzzs/GeJVXk83GucamYTN+KImijVHedM2puv+FJHlRvxonKeB/IIbsiXjGD4GZ+
	mNK6Pn7WhZEknxtI7pQDOn2hdfhtzKuq85FQZ2/XjcKWyhdH+AGE2GNYBRPReIgVARjk2qoGw2G
	gsT/8F5nVZguvTYND2TpGsquI4X+WpOwVUdYEUmZI+/3m4peULSLwVS86fLZjpt0+UvpvtmTVJ/
	y97K7JzJj5GUCudalMCmP0ekAktIzYjEB4iimgoiZiFFfojUSYtuofg8cHGGVUC5XWx8fHw11rx
	Xiad76uJcfMVOsQUQUSnkUdpW/Om3r6YjHdN3VdLhSIMtITtwY8avWUacoO1XcGv2EVsUStL30D
	Fdw3I4Xfc7IW4rkYtqtPn436cG5cpC9QLpsp03aBpRMNZ6mHhGenM8jiVPLUY6N9X4cnqoJQWNH
	ZFdAtrFpL0tF9n/4Z+3V/peGKIzqU=
X-Received: by 2002:a05:6000:402c:b0:439:ca12:d4ee with SMTP id ffacd0b85a97d-43a04d8dc84mr6755304f8f.25.1773411602949;
        Fri, 13 Mar 2026 07:20:02 -0700 (PDT)
Received: from berwick ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a78cesm17215509f8f.11.2026.03.13.07.20.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 07:20:02 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] worktree: stop using "the_repository" in is_current_worktree()
Date: Fri, 13 Mar 2026 14:19:47 +0000
Message-ID: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.52.0.362.g884e03848a9
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This is a follow up to pw/no-more-NULL-means-current-worktree that removes
"the_repository" from is_current_worktree() and get_worktree_git_dir().
The first patch removes the use of "the_repository" when determining
if a worktree is current. Patches 2 & 3 require a non-NULL worktree
when calling get_worktree_git_dir() to remove the last use of
"the_repository" in that function.

Base-Commit: 7f19e4e1b6a3ad259e2ed66033e01e03b8b74c5e
Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fworktree-is-current-use-repo%2Fv1
View-Changes-At: https://github.com/phillipwood/git/compare/7f19e4e1b...1151b5b30
Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/worktree-is-current-use-repo/v1


Phillip Wood (3):
  worktree: remove "the_repository" from is_current_worktree()
  worktree add: stop reading ".git/HEAD"
  worktree: reject NULL worktree in get_worktree_git_dir()

 builtin/worktree.c      | 21 ++-------------------
 t/t2400-worktree-add.sh | 28 ++++++++++++----------------
 worktree.c              | 10 +++++-----
 3 files changed, 19 insertions(+), 40 deletions(-)

-- 
2.52.0.362.g884e03848a9

