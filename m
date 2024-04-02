Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9560EC3
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054362; cv=none; b=dLIOtAr5LUCIYLkDQ8C6NbCjZl4Vg1MjoYS29kveLTth+iYu+FSJ0hZgiiBGEFe4L6wAeoxfRA1dO6NacDB5jgTYXSIcfPVp5oxnkSwYi3Oi4CCBqniREj2dmW0vWSMTqKa5eYhgTqxGENnrD9pQqdfJEzpD7xxwdvwDCu9JIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054362; c=relaxed/simple;
	bh=b7bYQzfUjD07Rud66omUozd/kiz/OyWuPS1Mf+zfz6Q=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=LsyGTWtAgtDb8X7DeZ116lSr1s83SZ5AHE9NnpFSZbgQve1uuOT4jsZ5wvwJHWOiDRft3phRYuMTBgZbK9Yh1sOPQbELpAqQgrrComhVMLD6dnoIIcOeC0PWOSozS+CkM+pT9FQodD6bD1pKkhcvrboe9n9qXKmQNI5REXAc2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShtyoNqv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShtyoNqv"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22a1e72f683so3747884fac.0
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712054360; x=1712659160; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0N9Y9JNvuXw+qvmNPqPzqp7lhQBUZmqkRShvKl5OBoI=;
        b=ShtyoNqv5hAKH3SljXRICZQ4BanogZPPST3UmBNGuBZN191ANTldNzH1et8x2keRTk
         uq0pdXj3U5NVVWgLwCZm9aCfx5R8Yy7TDflknOdU3iW2D237vbseKQVeUOSNxq96sUOT
         X4S6xAhSIlWndBXkBRPeRv/DZOTIW1h9hfktlN5nP7af5d4/cxeGcfbyPWoFoL6wguoc
         Pv5NZetnaRIYyTLHcQRsD/OV7lmRM8zbldkL+JKg0FNo3nbd7NQMai4gru98LRqv4KVl
         m0HFPvjC1yN8oAcUND4VstWiMLUyjr5bhgjhkYya/4xH0Za9+igdMI2UUrvKpNWkH3QJ
         +jgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712054360; x=1712659160;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0N9Y9JNvuXw+qvmNPqPzqp7lhQBUZmqkRShvKl5OBoI=;
        b=FgcXjRShWvwyq96SsK4LR1afWD8WcQbYckkzarBZSC9ee+yenJThRjR2N6oYeJeXK8
         l09yNbjf8O6BWeUAbtfeqoYQ1viuLVMJS9kxxyqX56tVsLDRwUjQc4FEbCOKd0AeueNx
         opNFVYDMs+h1GLFHfFnaTnZ/jHnaNCeQGTBpRDHy4vazXpeDtkLdRGpa8ZuzHVeJXpNG
         HkZpKRRIDagV9T3neKLlgAp8UWOu4/+UOC73vDn2kKuvUQTTQq37E9kU5hazgmMEfNSX
         zq9B5ZBvhDvVWPJ+Mr2cL6NE1YGHDnlRHWW9K+QkA+lx5NF8AgYk9HAyNb2ZeMyVA4uo
         5oQw==
X-Forwarded-Encrypted: i=1; AJvYcCVOrSZIcebH6GyjxcBBoe++mRvzIY/Vyuwm+DM2uAa1WL68euMXycRLCzGIVj/VnVdzIAwhipKg51uoetoj4GP2KOzj
X-Gm-Message-State: AOJu0Yy4Ef6RsmYERK8uAkDMNPD7IQuEsHWeO0LFJtLLyeESYYUlylrI
	w0brDF7jUufAq0KkU2JULcy1XmCaa7Ws54IDEZmuj9RManL5bwdnuxA6vTB6FS+AUKL7H5wKRLD
	1/EIvFELHHAdgwlhm2EEonPsGGylILJxW
X-Google-Smtp-Source: AGHT+IFLX0X4ADP2k3N6bHN9KN2LkvqZ0KWQKl2aqWIIqhJaXkunQjfgsAyBDoNPVN9L1ArUC4EaTFNuxuE1NVG9K28=
X-Received: by 2002:a05:6871:48e:b0:220:b839:4bb0 with SMTP id
 f14-20020a056871048e00b00220b8394bb0mr14229066oaj.19.1712054359775; Tue, 02
 Apr 2024 03:39:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 2 Apr 2024 03:39:18 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CAHCXyj2y131B6C+EA9fn2zPhx+LBsL9csHgJSy4GmK9xjdMQSg@mail.gmail.com>
References: <CAHCXyj2y131B6C+EA9fn2zPhx+LBsL9csHgJSy4GmK9xjdMQSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 2 Apr 2024 03:39:18 -0700
Message-ID: <CAOLa=ZS_pZEU+BHXoTpQyJy6Sn7j+ap5J+mZWOgnL39HKhK1Ww@mail.gmail.com>
Subject: Re: [GSoC 2024][v2 Proposal]Move existing tests to a unit testing framework
To: Aishwarya Narayanan <aishnana.03@gmail.com>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000f3766a06151ab771"

--000000000000f3766a06151ab771
Content-Type: text/plain; charset="UTF-8"

Hello,

Aishwarya Narayanan <aishnana.03@gmail.com> writes:
> Dear Git Organization,
> I'm writing to follow up on my Google Summer of Code proposal, "Move
> Existing Tests to a Unit Testing Framework."
> After careful consideration and based on our discussions, I've refined
> the project summary and deliverables to focus specifically on Move
> existing tests to a unit testing framework.This email aims to gather
> feedback and initiate a discussion on the
> feasibility and implementation of this idea.

It's always better to send updates as responses to your previous emails.
This allows for reviewers to contain context in a single thread.

> Related Works
>
> https://lore.kernel.org/git/CAHCXyj3U69qyhYewOLY9hN2rvi_5ZuSxQEBJbDxrKefm9MzVWg@mail.gmail.com/
> - Microproject Approach
>
> https://lore.kernel.org/git/ZgQffea0krKmZUEt@tanuki/ - [RFC PATCH]
>              Description: While printf might be unlikely to fail
> here,I felt the change aligns with the project's goal of ensuring Git
> command exit codes are captured. This approach is more robust and
> avoids potential issues in the future.
>                Status: Declined
>

It would be nice if you could also add a summary on the approach and
what went wrong and why.

> https://public-inbox.org/git/xmqqttkqwfwe.fsf@gitster.g/ - [RFC PATCH]
> Fix Git command exit code suppression in test script
> t2104-update-index-skip-worktree.sh
> Description: This patch increases the robustness of Git's testing
> framework by guaranteeing that Git commands' exit codes are
> appropriately examined during test execution. Previously, suppressed
> exit codes allowed tests to pass despite Git command failures. This
> fix stores the output of Git commands in variables and examines their
> exit codes to detect errors.The discussion focuses on improvements to
> the patch submission process, such as adhering to coding principles
> and referencing appropriate documentation for proper formatting and
> test script adjustments.
> Status: Declined
>

This patch actually was reviewed by Junio [1] and there was no follow up
from your side. I'm not sure how this was considered Declined, so it
would be nice to have some reasoning about it.

>
>  https://public-inbox.org/git/CAHCXyj1hUVNNuCOgsNv4GJUi79_o9iWZDvV8Ocz3DodreYoL7g@mail.gmail.com/
>   - GSoC 2024 [PATCH v2] Fix Git command exit code suppression in test
> script t2104-update-index-skip-worktree.sh
>                                  Description: This patch resolves an
> issue in Git test scripts in which the exit code of git ls-files -t
> may be disregarded, resulting in tests passing despite Git command
> failures. The new version guarantees that Git commands used in
> pipelines produce captured output and perform adequate exit code
> checks. It also enhances code style by adhering to established rules.
> This adds to more robust Git testing by ensuring the identification
> and reporting of Git command errors within test scripts.
> Status: Under Review

This seems to be the same patch as the previous. A new thread was
created here instead of replying to the previous thread.

> Porting Unit Tests:
>
> [1]https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/
>
> This patch series provides unit test functionality for the Git project.
> The series includes the following patches:
> A project plan document that outlines the goals for introducing unit
> tests, as well as a review of potential frameworks and the features
> used to assess them.
> An implementation of the TAP unit test framework with a sample unit
> test and Makefile integration.
> Changes were made to the Git build system so that the unit tests could
> be run in CI.
> The TAP framework was selected because of the following advantages:
> Simple to use and comprehend.
> Widely used and integrates seamlessly with existing Git tools.
>
> The project plan document mentions a number of outstanding TODOs,

Maybe I missed it, but where are the TODOs stated?

> Next Steps:
>
> A following commit will port the relevant code from
> t/helper/test-date.c to the new unit test file t/unit-tests/t-date.c,
> using the newly introduced functions for pre-requisite checks.
>
> [5]Unit Testing in Git:
>
> https://github.com/git/git/blob/master/Documentation/technical/unit-tests.txt
> discusses unit testing for the Git project. This gives an idea of the
> background and importance of unit testing in the project applying to.
>
>
>
> During GSoc
> The main goals of this project are:
> 1. Understand the existing "reftable" unit tests: Examine the present
> implementation of the "reftable" unit tests in
> 't0032-reftable-unittest.sh' to ensure that you understand their
> functionality and purpose.
> 2. Learn the new unit testing framework: Get a thorough grasp of Git's
> new unit testing framework, including setup, usage, and recommended
> practices.
> 3.Ensuring test coverage and reliability: Check that the converted
> tests have sufficient code coverage and accurately simulate the
> expected behaviour of the "reftable" capability. Test and validate the
> new tests thoroughly to ensure their reliability.
> 4. Documentation and code comments: Document the conversion process,
> including any issues encountered and the reasoning behind design
> decisions. Update the code comments and documentation to reflect the
> changes to the tests.
> Deliverables

Kaartic's review in the previous version mentions [2]:

    Your project summary and the deliverables below seem to mention that
    you're going to work on migration of the reftable unit tests but the
    project title seems to be "Move existing tests to a unit testing
    framework'.

It seems this version is the same...

> Closing Remarks
> Finally, I'd like to express my gratitude to the community and, in
> particular, my mentors, Patrick Steinhardt,Christian Couder,Kaartic
> Sivaraam,Karthik Nayak,Junio C Hamano. They did and continue to do an
> exceptional task of maintaining and empowering the Git open-source
> community, as well as offering much-needed and kind assistance to a
> new contributor like me.
> ---
> Sincerely,
> Aishwarya Narayanan
>

It would also be nice if you mentioned what exactly is different in this
version compared to the previous.

[1]: https://public-inbox.org/git/xmqqttkqwfwe.fsf@gitster.g/
[2]: https://lore.kernel.org/git/CA+ARAtpqD0um9bVrjRKG0DmrxVR-46uSKfDKnO+H1rUp0i+4Ww@mail.gmail.com/#t

--000000000000f3766a06151ab771
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e784d684475c7e87_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZTDRGSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meWJ6Qy80eEx6QTN4NGtuakRuWC84S0I1c0l3Nk9oWAo1bktuT21PSzdJ
ajJPcGJubUM2dzh2Mk9KVmNvUUdWbW1oaXNscFRZTElIdUVHQ2JyTmVNMDlnU0lXanRMZjNECmx6
Tm1EaWd5NG0wV084cEhCVXRreDA3UDYrTVB3S1g1a2J3T1ZkNkFWSVM2ZzF1RXdXblQxNGxTQ2pQ
bENDNC8KY3lYMmRkaEhVL01wT0kzMjZMSVdnODlmYXFLVWc1WEEzZFJxYkdzK1FTOWx1Z1hXVTVU
c1F0bzRVQ2Z0bE16Qwp1MlFwNlhocnVCdGNlRzZuWG90YVFQYmoxR3JheUYwZ0VTT0RoWitmdE51
UCsrdk1aS2Fxc0J2UmtCUC9JZ2JYCjlKalVxNERlK3NsLzN0QjBxd2s0Zys2TjFPcUxUcXdEczEw
RVgwWGJHQ29aaEIvVms4QWZyWUFnSGYzNUptVGgKVXpWM3V0bVlpa0xRWWlWUG1IMHBQWXdDUmVI
Z2RQZGNseXRDQVZqSUZnaWpFMm5iZmx0VmFxYjRTM01ITHFBbAoyQVNyMy8vL01xT2VsQWFyT1d2
Q3c5S0ZrUWRWWjVseGxOeXFoeVFQWnhCRHB3M1pqd2Q3cklWWWhPZUJ1VkZwCkx0eUJtbDNIVm5T
Zm4zVkgxN1hFUm5yUVMzVkk5OEcweGlVaVc5dz0KPTY1dDcKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000f3766a06151ab771--
