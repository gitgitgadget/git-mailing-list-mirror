Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB47BE65
	for <git@vger.kernel.org>; Sun,  6 Apr 2025 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743919705; cv=none; b=F8yR9m9HWZdKhIwjSI5HCflN0eXMCboqovEst1JGJo8IIdNqs6xUvK9BId90V3l6xJIBIQb+MpdLAevZ3JCruq5PgPnAVYLmlPRJfHa/9P9cjSUEzQ389I7CD1hzGJi29mdlbhKnpb8VzRTLl0C46fgoJfhoA+X3LFVxfdkZF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743919705; c=relaxed/simple;
	bh=qTzYDc5oiJkcHJFueOXmUUtCpXB1RO2AVGiH0fpqBbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=P0A3xTy3J95klB8cNph/9I+aY8lMSrpAM88zVWZ/W1ZvR2FUB8PxudKj/7tx7lkRjrjTgTFRAUPiLAyOGo6XO7uZuY4bgF2z1Umc+wOmqmLPI3sg05D+QBhvKzyqmCtDxZgrgyg7PfYIXajLL0+gGaadPMlaW0nX2evuqLJbMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lolWpk88; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lolWpk88"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfc8faef9so32420451fa.1
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743919701; x=1744524501; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fs5MEKI73jrg2JCJbbSSsUiHDe8GTBzOCmmHixdqAD0=;
        b=lolWpk88M/VV7IDfAd+Ui5WLNKfn0bMkZdrvcKdZEWD8nRuDyR9aJyoFDogVOt3Hbl
         gGjWZMysMzeOR3jZOcC6A4/rbWfBUA0qeLIwyTpBjtHQKoAHSJFjQbnEosuIr4/WAH6i
         heEnOrrwW67gSfASDPDT+Kf2PudaZQ+okgYx7J9Rrq6WCcCY7sqZxALxAYwYmYWg8Zag
         HwHT5swLLft5854JaE8GYQT2RgLVTt1Du8RtCLsIfEmeflHrKPeVJ3giSHqiPLsY5dfr
         S0cnbuYFREHvVk6rAQ7Sx0Za+E67JxuaGxvuR3NBrtFe5z9IOkCd/2EkKwHQWSpHwy2z
         HEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743919701; x=1744524501;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fs5MEKI73jrg2JCJbbSSsUiHDe8GTBzOCmmHixdqAD0=;
        b=myNREj12OCxTkoNYWI25hZGi7HH6Obn+B8MgmaswxPjMSlWn2MNvPEtlv0Koq63/xf
         iyvmwwGOIvtz6FSuzPjmZm0enGAVVMH4dAlHXAXLYwb4Dq/TWCbI9YVricECaYuQUUza
         ZL7KDuYi3Hhl7WiJwUImqCLtv5kPFZYF9aZt08LePv/7PaI/caHDOF6rg7jzNtJj7yjF
         SihHr86xWp+IvLYm6bNHKzRdN6tZSnEO9H/bZY6LFQsWGRjdHiiFj8I2qWw1vszkgmfO
         dmd2osDn94QDgQV5Ob7XjbbG1F0PQpfj0MX4O2U12LRgA/iT1ZoZkqPUveLN6gv+daq/
         Pgkg==
X-Gm-Message-State: AOJu0Yxg3yQvTqwYzyTtQzsJ49auOrPQWLnY9cLNQESV3urggFhF50c7
	nOtXVuBC2IlkYRm/Aj8gDnHLdBE4BDvjVMvyCodzXgL+tLjwcFi66AQiUNGrU0zyM1DxE5XBn7s
	7m95mZsuCx5dGmhOPIKwSyCXU0dj+vPI9Bbs=
X-Gm-Gg: ASbGncuBMKDy6ob8pW9Jk1kPEwcUcvLmNCA0011Ds02Kdj2Kf0Z/jPj/oNbRDmm7ZRf
	lpbSD/YnGDCgl/UlFmgnkMW83mW8m7zW0IPvauX6dJDMt+fRlnR8dDLS1DJnxE7c0cbjZYZV2xw
	/4eGm2kJjJtm1lqAxFDWctJh/qFzyBdOZlO61LPFC7g5ZQ3I4MV5RPKgJIibg9
X-Google-Smtp-Source: AGHT+IHRAr7X0s1q0LBqv9wtOzgHIZ58hMt8JODIuSJhl9T1zywHKmpqU6Ka+Vn/54RdmT3pxDA5A4YfkdoqBMNEWJI=
X-Received: by 2002:a2e:a908:0:b0:30d:e104:a945 with SMTP id
 38308e7fff4ca-30f0a1ac43amr18917491fa.41.1743919700851; Sat, 05 Apr 2025
 23:08:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfWy7ZMspWg@mail.gmail.com>
 <20250329150248.2274482-1-05ZYT30@gmail.com>
In-Reply-To: <20250329150248.2274482-1-05ZYT30@gmail.com>
From: Yuting Zheng <05zyt30@gmail.com>
Date: Sun, 6 Apr 2025 14:08:10 +0800
X-Gm-Features: ATxdqUFa-iMHRnol8gUl80vFwLZ8Gy7FPKCpqVU4N7O2c53YOTLX49XjswR4CD0
Message-ID: <CAMvj1+rUYPpOzo78RJurj4Lcoop=hPQ0G6_e2eK6TD55tdGPkg@mail.gmail.com>
Subject: [GSoC] git-refs proposal v2
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

## Name and Contact Information

- Full Name: Zheng Yuting
- Email Address: 05ZYT30@gmail.com
- Time Zone: UTC +8:00

---

## Abstract

The current Git reference management functionality is fragmented across
multiple independent commands (`git-show-ref`, `git-for-each-ref`,
`git-update-ref`,
`git-pack-refs`, `git-check-ref-format`, and `git-symbolic-ref`),
leading to code
redundancy and increased maintenance costs.
Based on Patrick Steinhardt=E2=80=99s integration vision[1], this project a=
ims to
consolidate functionality under the unified `git-refs` command by initially
implementing three core subcommands: **show**, **list**, and **update**.
These subcommands will cover the most essential reference management
operations while ensuring backward compatibility and laying the foundation
for further refinement.

If time permits, additional subcommands (such as `exists`, `resolve`, `pack=
`,
and `check-format`) will be gradually integrated to extend and enhance the
existing functionality. Comprehensive testing and updated documentation
will support this phased approach, ensuring a robust transition from the
legacy tools.

---

## Implementation Plan

### Command Integration Strategy

#### Implementation Sequence

The development will proceed in the following order:

1. `git-refs show`
   - **Purpose:** Replace `git-show-ref --verify` with strict
reference validation.

2. `git-refs list`
   - **Purpose:** Merge `git-show-ref` and `git-for-each-ref` for
listing references.
   - **Output Format:** `<oid> SP <ref> LF` (git-show-ref style).
   - **Options:**
     - **Filtering:**
       - From `git-for-each-ref`:
         - `--count`,
         - `--points-at=3D<object>`,
         - `--merged[=3D<object>]`,
         - `--no-merged[=3D<object>]`,
         - `--contains[=3D<object>]`,
         - `--no-contains[=3D<object>]`,
         - `--omit-empty`,
         - `--exclude=3D<pattern>`,
         - `--include-root-refs`.
       - From `git-show-ref`:
         - `--head`,
         - `--branches`,
         - `--tags`,
         - `--exclude-existing`.
     - **Sorting:**
       - From `git-for-each-ref`: `--sort=3D<key>`.
     - **Formatting:**
       - From `git-for-each-ref`:
         - `--format=3D<format>`,
         - `--color[=3D<when>]`,
         - `--tcl` (under discussion),
         - `--shell`(under discussion),
         - `--perl`(under discussion).
       - From `git-show-ref`:
         - `--dereference`,
         - `--hash`.
     - **Global:** `--ignore-case` (applies to all filtering/sorting).

3. `git-refs update`
   - **Purpose:** Replace `git-update-ref` with transactional updates and
batch processing.
   - **Options (all from `git-update-ref`):**
     - `<ref>`: Target reference.
     - `<newvalue>`: New object identifier.
     - `[<oldvalue>]`: Expected old value (atomic check).
     - `--stdin`: Read batch updates from stdin.
     - `-d, --delete`: Delete the reference.
     - `-m <message>, --message <message>`: Custom reflog message.
     - `--no-reflog`: Skip reflog updates.
     - `--no-deref`: Update symbolic refs directly.

---

#### Testing & Documentation Updates:

- **Unified Testing:**
  - Develop comprehensive test cases for each subcommand to ensure
that the new commands produce outputs consistent with the legacy ones.
  - Leverage existing test scenarios (e.g., those used for `git-show-ref`
and `git-update-ref`) and add new tests specific to the new option
categories and output formats.

- **Documentation:**
  - Update the user manual (e.g., Documentation/git-refs.txt) to include
detailed sections for each subcommand, mapping the new options to
their legacy equivalents.
  - Provide developer notes to explain changes, highlight areas of
functional parity, and outline the phased implementation approach.

---

### Timeline

- **May 8 =E2=80=93 May 17 (10 days):** Design Finalization & Alignment (pu=
blish
proposals, resolve conflicts).

- **May 18 =E2=80=93 June 7 (21 days):** Implement `git-refs show` (include=
s
testing/docs).

- **June 8 =E2=80=93 July 3 (26 days):** Implement `git-refs list` (include=
s
testing/docs).

- **July 4 =E2=80=93 August 4 (32 days):** Implement `git-refs update` (inc=
ludes
testing/docs).

- **August 5 =E2=80=93 August 25 (21 days):** Cross-command validation &
edge-case fixes.

- **August 26 =E2=80=93 September 1 (7 days):** Final Review & Adjustments.

---

## Background & Experience

I graduated in June 2024 from Wenzhou University with a degree in
Network Engineering. My experience includes C programming and
command-line tool development, along with proficiency in Shell
scripting. I am currently in a transitional phase and expect to finalize
my schedule by late April, and then update my weekly schedule for GSoC,
estimating 25-30 hours per week for this project currently.

### Project Experience

- **One Student One Chip Project[2]**
  Extending the open-source NEMU simulator by implementing CPU cycle
  functionalities in C.
- **Web Development**
  Developed a Django-based campus website, including user chat, news
  publishing, and teacher management modules.
- **Custom Communication Protocols**
  Built a UDP-based chatroom with peer-to-peer and group messaging.
- **Stock Monitoring Tool**
  Implemented real-time monitoring and historical data analysis, with
  email alerting and planned AI-driven strategy optimization.

I have also obtained CCNA certification and gained hands-on experience
as a network engineer. Additionally, I contributed a patch (currently pendi=
ng
merge) optimizing send-email functionality in Git [3], which has given me
valuable insights into the Git codebase. For reference, my draft proposal
discussions can be reviewed on the mailing list [4], and `git-refs list`
discussion on the mailing list [5].

---

## Appendix

[1] https://gitlab.com/gitlab-org/git/-/issues/330
[2] https://ysyx.oscc.cc/en/project/intro.html
[3] https://lore.kernel.org/git/20250312064639.668875-1-05ZYT30@gmail.com/
[4] https://lore.kernel.org/git/CAMvj1+rbYKFNeWEvvN76MTpzfuWc4TN4ViXRE4nTfW=
y7ZMspWg@mail.gmail.com/
[5] https://lore.kernel.org/git/20250403154404.3459805-1-05ZYT30@gmail.com/
