Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A5718DF7D
	for <git@vger.kernel.org>; Mon, 28 Oct 2024 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730102872; cv=none; b=jIJid3EfZTQPaKK4LIIKQqY4CrpK7NNgymDl8H2LGAeRpWdSitYFhKuNVz9ZqT+5OVgEoJn3tYJNM5EdCQhUfHJ82Twy6EJAQJ11zWDKv4olv4iPS1t910DCLJzUmzhqn54ZnU9jn7KLKkOTawehX5OgWhp8hXDfYuanJRvARlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730102872; c=relaxed/simple;
	bh=is/DVRNNdVr4biTfFzuZn0SBbGO2vBummhzRQTLAjao=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fkvXUZM9YGrVWSSD7oPnAij1RFr85rhJlUudYTgwKsG9w0moPlIOsL8gAuCVf1eIQtP05MRobMkDnvzN5oRIpMQseDiNBtjkRsdJ4+APjD2ePif5xrhN3tz1g8KmEJuiknOOpUdi1THBmPUQ40r+rWCokF7xzvekik6cjl06DdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEw8F9iw; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEw8F9iw"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-431695fa98bso39512695e9.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2024 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730102868; x=1730707668; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yMqZdeoJLsss9JKW/TqG+5DS3rFdcBTGHfBzctDj1tU=;
        b=nEw8F9iwce+Gej6/DKGVyCvrzOD0DQNmGxfs0aJMtYzcWJlsILpV2juTt4h1uENgn4
         /XdfGTnbKk4gWd4ilmG4dK0AYB4Vjk5KIFe82YLPKRGJeuzdR9u+SgRWzWi196X6Q9Vg
         oo1fIjxLTriO5xeqbLzWfo2uvtZivxb3otm2tET1GeLm24Ciixjkq+fdWO08nLlW1ZwD
         OQx3zi0We1wVBh/Qqvp+oyGXO0XoIaEMxSTReYe8lSB9rnDV1qwrKuDH5Gl8QtiSOkVX
         Gx9LzSBfX1Dst9f5lvpxoOxJgnkF6K6SA5FGkMbVNqoJFIx0eQYkNj9rPfmeKgq9RBda
         frGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730102868; x=1730707668;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMqZdeoJLsss9JKW/TqG+5DS3rFdcBTGHfBzctDj1tU=;
        b=FS4p5wNJON0FPznCH/qcSe6TesuFliVqI58bXK6C6q56NOtRIRK89KlnM+UC55GPM0
         00SZp3vNtqUQ4Amd8kLCtg8OgtrVgqGNEf/z1LlSuGdB12yn4/ZMrxm93or8LMlenXcj
         p1xKpEBjwjXZWzPLGlIpSRXUQrrEhdh0li41BvXbO9o9D/gl5Co88/++Jtv4GJLqWeOI
         lFCntyODOn0hr68PxXOwLwBlWYfoSJXmPAD3JPfDBjdcYoVbnlZ386bxQX17vbpA7MXS
         1YzwD1Lb2ueuYQ3lOrag0LsqKVN7DMXsFZEka73Kg7hvgyoGDdhMwfoiZfAIMiAn9fad
         s69w==
X-Gm-Message-State: AOJu0YwblaZFw37uQXUf4EOe7WDCfCf5lMEKWDejC540MQ+JWchqpUku
	x/EAsmLBdNuGVR1GdDAwKUU2ZZT//xc9jMrG0PpyyEwL/yhSa7IEgNkpYV+JY3qm5nz4FcKKeeo
	Irn7XnGCRAATvbtcZAEQ3IkMr8VhZVxs6C1twcpuJ
X-Google-Smtp-Source: AGHT+IEXel6QYkgcWHAhNhIVoOH8tCBSj79QyrsVFRuGw23cAQuZitDmI1iCMN/edpKEDF0DAGqHR6pB8L1QNmKwA9o=
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr64173745e9.25.1730102868064; Mon, 28 Oct 2024
 01:07:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Mon, 28 Oct 2024 08:07:38 +0000
Message-ID: <CADYq+fYu-n_msHbFgfzN+i4Xxp+MpAPmgPZXYJzn5vs+kZCG3A@mail.gmail.com>
Subject: [Outreachy][proposal]: Finish Adding an os-version Capability to Git
 Protocol v2
To: git@vger.kernel.org, christian.couder@gmail.com, 
	Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git Community,
I hope you are doing well.

## Introduction:
My name is Abraham Samuel, I am participating in the December 2024
Outreachy internship program and
this is my proposal for the project "Finish adding os-version
capability to Git protocol v2".

## Contribution to the Git Community:

I have participated in contributions to Git=E2=80=99s codebase after gettin=
g
accepted into the contribution phase in October 2024, working on what
I found doable and within my reach. Below is the list of my
contributions:

- [PATCH v4] t7300-clean.sh: use test_path* helper functions for error logg=
ing.

       List thread:
https://lore.kernel.org/git/pull.1811.v4.git.1728498122419.gitgitgadget@gma=
il.com/

       Status: merged into master

       Merge Commit: 77af53f56f100b49fdcf294f687b36064d16feca

       Description: The patch converted instances of  =E2=80=9Ctest - [def]=
=E2=80=9D
in test cases to test_path_* functions to get error logs when the test
case fails when testing for the existence of a file or directory after
=E2=80=9Cgit clean=E2=80=9D or =E2=80=9Cgit clean -d=E2=80=9D is called as =
the case may be.



- [PATCH v4] notes: teach the -e option to edit messages in the editor

       Status: integrated into Seen

       List thread:
https://lore.kernel.org/git/pull.1817.git.1729296853800.gitgitgadget@gmail.=
com/

       Description: The patch worked on a #leftover bit which added
the =E2=80=9C-e=E2=80=9D option to =E2=80=9Cgit notes add=E2=80=9D and =E2=
=80=9Cgit notes append=E2=80=9D subcommands
when the message is supplied with the -F and/or -m options. The patch
enables fine-tuning the message by invoking the user=E2=80=99s default edit=
or
prefilling the message in the editor to allow editing the message to
the required taste before adding the note to the commit

## Project Overview:
This proposal outlines a plan to complete the work on the os-version capabi=
lity
patch series for Git's protocol v2. Initially introduced in June 2024,
this feature intends to enhance
communication by allowing Git clients and servers to share their
operating system (OS) information.
The capability aims to provide metadata that can improve issues
diagnosis and enable statistical insights.

This project will involve refining the original patch which already
started the process of adding this feature,
addressing Windows compatibility issues, and implementing
configuration options to customise how the OS is
shared.

## Intern objectives:
The key objectives of this project are;
1. Finalize 'os-version' Capability: Modify the existing patch series
to meet community requirements and improve
functionality, ensuring compatibility with different OS environments.
2. Add configuration options: Create options that allow users to:
    - Share only the OS name by default (eg, "Linux", "Windows")
    - Disable OS information sharing completely
    - Include a more verbose OS version display using commands like
uname -srvm on Linux
3. Fix Windows Compatibility: Review and resolve issues with the
current tests on Windows, ensuring full cross-platform
support
4. Ensure Tests Coverage and Reliability:  Create robust tests to
verify the feature's functionality across supported platforms,
incorporating community feedback to refine and improve the patch series.

## Approach and Methodology
1. Analyze and retrieve the existing patch series:
    - Retrieve patches from the Git mailing list
    - Review the current code and community feedback to understand
necessary improvements and privacy concerns

2. Apply and test the patch on a new branch:
    - Set up a new branch based on master to isolate the work on the
os-version feature
    - Apply the patches and perform an initial round of tests to
determine specific errors and how to address them

3. Address Community concerns and implement improvements
    - Implement feedback on sending only the OS name (eg, "Windows")by
default using uname or equivalent method on different OSes
    - Add configuration options for users to adjust the level of
detail in OS information sharing
    - Allow toggling the feature off for privacy or preference
    - Ensure that configuration changes are well-documented and user-friend=
ly

4. Resolve Windows Compatibility issues:
    - Address current test failures on Windows, working closely with
community inputs to meet compatibility standards
    - Modify any OS-specific code or test as needed, to work across environ=
ments

5. Develop and refine tests:
    - Ensure the test case covers all functionality: OS name  sharing,
version details and disabled state
    - Conduct platform-specific tests on Linux, Windows and other
environments to confirm accuracy
    - Incorporate feedback from mentors and the community to finalize
the feature's functionality and robustness.

6. Document the feature and prepare for submission:
    - Write documentation and examples for configuring the os-version
capability, explaining options and use cases
    - Prepare the final patch series, following Git's contribution
guidelines for submission to the Git mailing list

## Timeline
1. Community Onboarding: (Week 1 -2):
    Tasks:
        - Retrieve patches and create a dedicated branch
        - Study past discussions and understand the improvements required
        - Set up blog post to write about internship experience
2. Initial Testing and Patching (Week 3 - 4):
    Tasks:
        - Apply Patches
        - Run Initial tests
        - Identify current issues, especially Windows compatibility
3. Implement OS version configuration option (Week 5 - 7):
    Tasks:
        - Add options for OS name, detailed OS version and disabled state
        - submit the initial patch series to the Git mailing list for revie=
w
4. Windows Compatibility (Week 8 - 9):
    Tasks:
        - Review, debug and resolve Windows-specific issues
        - Perform cross-platform testing and verify functionality
5. Test Expansion (Week 9 - 11):
    Tasks:
        - Write comprehensive tests for OS version capabilities.
        - Integrate tests to cover each configuration option.
        - Submit initial patches for tests to the Git mailing list
       - Implement community feedback and reviews on submitted test patches
6. Finalizing and Documentation:( Week 12 - 14):
    Tasks:
       - Finalize code based on community inputs
       - Prepare final patch patch submission with full documentation
      - Complete my blog on internship experience

## Availability:
I will be available to work for a minimum of 30 hours per week and I
am not currently
enrolled in any academic activities or have any jobs.

## Post Outreachy:
The Git community fosters proper and effective communication,
regardless of one=E2=80=99s level of experience. The patience, guidance and
explanation of technical concepts shown by community members are
wonderful and this has made me grow not just technically but also
behaviorally. Due to this, I plan to continue actively participating
the in Git community and be part next generation of those saddled with
sustaining this great project and preserving its legacy.

## Appreciation:
 A special appreciation to everyone on the mailing list for reviewing
my patches, the mentorship and guidance
I am grateful to you all.

Thanks
Abraham Samuel
