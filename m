Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6E8C64ED6
	for <git@archiver.kernel.org>; Sun, 26 Feb 2023 09:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjBZJDV (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Feb 2023 04:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZJDT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2023 04:03:19 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3432119
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 01:03:15 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id g12so1870580pfi.0
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 01:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6g22IcIQj6oxL1m+9WJIMrIIn8JkXrCFw11Se9GCFA=;
        b=qfWi4rXx4E4EyBns1IKxpb5SpnlBUT35hR1OobWvzb4vn9xJk68ziwB+QlNueMXve7
         Juwj14K9q8SGklvZldAplPEaeY1LaVpUI60jTd/wwcbYXmSnq5bE17QCpHcUrJf44L/a
         dA6U/sG/OLg35EhDWBPTjV5Fzf4olf+r423inEFpEuJEgjZBJJkS6YeFCnaQrB1Ywa2V
         ZkhUMZNx8TqUKB53nYRD4+9QP6GoiX6uvC/E/XjrIVsXJNZWx8eFd5E8rz1ZPDRLqjx9
         x6mh1gVs52F/qmCk1kq7ObFIFspRwuT6vt3XSquoAfg1pMBklqMvNbvx1NLaQLxP8zoF
         mWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6g22IcIQj6oxL1m+9WJIMrIIn8JkXrCFw11Se9GCFA=;
        b=zCY50bHfvjkChmKMjoxlAnlLc45KjEwf6K/pIHML+9SnxxsorBHMBDelgBTV0dbAjj
         2cSCKQjiFNRk919vLMSgd0Zv/XGFTMQanhelDNOpRocjzpNoYOT/I92OJNrpfHXQuWhp
         310MKmCx+ZGCMUAlUnj01KDEHRdXI2Q3K+21iS+Dcq3g7BDjQBr5sI99NjESYpwVl52x
         ihuNA3QkAFKOpBJj0D7yjg5VhfdHEMDPFv9/U/tzu2O1WrNRb1QcdnD4yFM08n7+HvJV
         PT9Y3sdf9bnN7wNUTwRUftCTypUbV0jYHgDF9xugTzzUWnPGPGwaLSoIUFLOaj/o53ze
         ae0w==
X-Gm-Message-State: AO0yUKXKDhfvIVmeNiAlX8eCg/XUKBPptwjvNO+pv5BOrGmckw1XflK/
        dJ3EL02Vs4wrBlJEyBeq+u/GNd+DiQqAxJGAqyU=
X-Google-Smtp-Source: AK7set+cx2WloULCxJx6RRMbeFmwvH3V6Hwuy86qXvzHT8sgK7AqTDFljGPh5Gbh7t1sOMBWqOaZFzizIgkxo6kXpV0=
X-Received: by 2002:a63:1226:0:b0:503:25c8:abde with SMTP id
 h38-20020a631226000000b0050325c8abdemr1181668pgl.1.1677402194699; Sun, 26 Feb
 2023 01:03:14 -0800 (PST)
MIME-Version: 1.0
References: <20230226083347.80519-1-gvivan6@gmail.com>
In-Reply-To: <20230226083347.80519-1-gvivan6@gmail.com>
From:   Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
Date:   Sun, 26 Feb 2023 14:33:02 +0530
Message-ID: <CACmM78QTptLOvNHs9oE2NNareSNDb+ydGFKr0VHuboCBWSZbSw@mail.gmail.com>
Subject: Re: [RFC][PATCH] GSoC 2023 proposal: more sparse index integration
To:     Vivan Garg <gvivan6@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, christian.couder@gmail.com,
        hariom18599@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2023 at 2:17=E2=80=AFPM Vivan Garg <gvivan6@gmail.com> wrot=
e:
>
> Signed-off-by: Vivan Garg <gvivan6@gmail.com>
> ---
> This is a rough draft of my proposal for the GSoC 2023 more sparse
> index integration project. I would greatly appreciate any feedback
> anyone has to offer. Thank you in advance!
>
>  .../More-Sparse-Index-Integrations.txt        | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/More-Sparse-Index-Integrations.txt
>
> diff --git a/Documentation/More-Sparse-Index-Integrations.txt b/Documenta=
tion/More-Sparse-Index-Integrations.txt
> new file mode 100644
> index 0000000000..dbe6da660f
> --- /dev/null
> +++ b/Documentation/More-Sparse-Index-Integrations.txt
> @@ -0,0 +1,134 @@
> +# More Sparse Index Integrations
> +
> +# Personal Information
> +
> +Full name: Vivan Garg
> +
> +E-mail: gvivan6@gmail.com
> +Alternate E-mail: v.garg.work@gmail.com
> +Tel: (+1)437-987-2678
> +
> +Education: University of Waterloo (Canada)
> +Major: Computer Science and Financial Management (Double-Major)
> +Year: Rising Junior
> +
> +LinkedIn: https://www.linkedin.com/in/gvivan/
> +GitHub: https://github.com/gvivan
> +Website: https://gvivan.me/
> +
> +# Before GSoC
> +
> +## Synopsis
> +
> +I've chosen the "More Sparse Index Integrations" project idea from the S=
oC 2023 Ideas page. The goal of this project is to integrate the experiment=
al "sparse-index" feature and "sparse-checkout" command with existing Git c=
ommands.
> +
> +Git 2.25.0 introduced a new experimental `git sparse-checkout` command, =
which simplified the existing feature and improved performance for large re=
positories. It allows users to restrict their working directory to only the=
 files they care about, allowing them to ensure the developer workflow is a=
s fast as possible while maintaining all the benefits of a monorepo.
> +(Bring your monorepo down to size with sparse-checkout, Stolee).
> +
> +The pattern matching process in Git's sparse-checkout feature becomes ex=
pensive as the sparse-checkout file and repository size increase, growing q=
uadratically. This can result in billions of pattern checks for large repos=
itories. However, Git's new mechanism for matching based on folder prefix m=
atches drops the quadratic growth, matching M patterns across N files in O(=
M+N*d) time, where d is the maximum folder depth of a file.
> +To further optimize the matching process, Git inspects files in a sorted=
 order instead of an arbitrary order. When Git evaluates a file path, it ch=
ecks whether the start of the folder path matches a recursive pattern exact=
ly. If so, it marks everything in that folder as "included" without doing a=
ny further hashset lookups. Similarly, when Git detects the start of a fold=
er that's outside of the specified cone, it marks everything in that folder=
 as "excluded" without doing any further hashset lookups. This reduces the =
time to be closer to O(M+N) (Bring your monorepo down to size with sparse-c=
heckout, Stolee).
> +
> +The Git Fundamentals team at GitHub has contributed a new feature to Git=
 called the sparse index, which allows the index to focus on the files with=
in the sparse-checkout cone in a monorepo. The sparse index stores only the=
 information about the files within the sparse-checkout definition, instead=
 of storing information for every file at HEAD, which can make the index mu=
ch larger in a monorepo. When enabled with other performance features, the =
sparse index can have a significant impact on performance (Make your monore=
po feel small with Git=E2=80=99s sparse index, Stolee).
> +
> +The sparse index differs from a normal "full" index in that it can store=
 directory paths with the object ID for its tree object. It can be used to =
determine if an entire directory is out of the sparse-checkout cone and rep=
lace all of its contained file paths with a single directory path. The use =
of sparse index can significantly reduce the size of the index, resulting i=
n faster operations (Make your monorepo feel small with Git=E2=80=99s spars=
e index, Stolee).
> +
> +Because "sparse-checkout" and "sparse-index" may potentially influence t=
he logics of other Git commands and the internal data structure of Git, som=
e work is required to optimize compatibility and user experience. That is e=
xactly what my chosen idea proposed.
> +
> +## Benefits to Community
> +
> +By joining the community and working on this idea, I can collaborate wit=
h my mentor and fellow community members to improve the user experience for=
 people who are working with large monorepos. Furthermore, I am committed t=
o continuing my involvement beyond the GSoC program, not only by contributi=
ng to the community but also by sharing my experiences and mentoring future=
 potential newcomers.
> +
> +
> +## Microproject
> +
> +t4121: modernize test style
> +Status: ready to merge
> +Description: Test scripts in file t4121-apply-diffs.sh are written in ol=
d style,where the test_expect_success command and test title are written on
> +separate lines. Therefore update the tests to adhere to the new style.
you should include a link here to Junio's what's cooking in git where
your contribution is mentioned.
> +
> +## Other Contributions
> +
> +### Reviewing
> +
> +t9700: modernize test script
> +Status: WIP
> +Description: I reviewed this patch and pointed the contributor in the ri=
ght direction by providing examples, links and mentioning the best practice=
s.
> +
> +### Patches
> +
> +MyFirstContribution: add note about SMTP server config
> +Status: WIP
> +Description: The documentation on using git-send-email previously mentio=
ned the need to configure git for your operating system and email provider,=
 but did not provide specific details on the relevant configuration setting=
s. This commit adds a note specifying that the relevant settings can be fou=
nd under the 'sendemail' section of Git's configuration file, with a link t=
o the relevant documentation. The aim is to provide users with a more compl=
ete understanding of the configuration process and help them avoid potentia=
l roadblocks in setting up git-send-email.
> +
> +
> +### Related Work
> +
> +Prior works on the idea have been completed by my mentors and other comm=
unity members, and these works provide a good approximation of the approach=
 I intend to take. Here are some previous examples of commits:
> +Integration with =E2=80=9Cmv=E2=80=9D
> +Integration with =E2=80=9Creset=E2=80=9D
> +Integration with =E2=80=9Csparse-checkout=E2=80=9D
> +Integration with =E2=80=9Cclean=E2=80=9D
> +Integration with =E2=80=9Cblame=E2=80=9D
> +
> +# In GSoC
> +
> +## Plan
> +
> +The proposed idea of increasing "sparse-index" integrations may seem str=
aightforward at first glance. However, upon reviewing previous implementati=
ons, I discovered that this idea can introduce unforeseen difficulties for =
some functions. For example, to enable "sparse-index," we must ensure that =
"sparse-checkout" is compatible with the target Git command. Achieving this=
 compatibility requires modifying the original command logic, which can lea=
d to other unanticipated issues. Therefore, I have incorporated some additi=
onal steps in the plan outlined below to proactively address potential comp=
lications. It's worth noting that points 3-7 are part of the SoC 2023 Ideas=
 proposed by the community and mentors.
> +
> +1. Conduct an investigation to determine if a Git command functions prop=
erly with sparse-checkout.
> +
> +2. Modify the logic of the Git command, if necessary, to ensure it funct=
ions properly with sparse-checkout. Develop corresponding tests to validate=
 the modifications.
> +
> +3. Add tests to t1092-sparse-checkout-compatibility.sh for the builtin, =
with a focus on what happens for paths outside of the sparse-checkout cone.
> +
> +4. Disable the command_requires_full_index setting in the builtin and en=
sure the tests pass.
> +
> +5. If the tests do not pass, then alter the logic to work with the spars=
e index.
> +
> +6. Add tests to check that a sparse index stays sparse.
> +
> +7. Add performance tests to demonstrate speedup.
> +
> +8. If any changes are made that affect the behavior of the Git command, =
update the documentation accordingly. Note that such changes should be rare=
.
> +
> +## Timeline
> +
> +During my discussion with Victoria, she informed me that given my commit=
ment of 175 hours, it is expected that I will be able to fully integrate tw=
o commands with sparse index during the GSOC program. My plan is to evenly =
distribute the work for each command over the course of the program. I am c=
onfident that I can start the project early as I have already established c=
ommunication with my mentors and familiarized myself with the related docum=
entation, although my understanding may not be comprehensive.
> +
> +Based on my prior experience with the idea, I believe I will be able to =
quickly get up to speed and begin working on the project. The exact timelin=
e for each integration is difficult to determine, but I estimate that I sho=
uld be able to complete one integration every two months. I have already pl=
anned out my next term, and there are only three weeks during which I would=
 prefer to focus on other things: June 23-30 and August 1-15. However, even=
 without an extension, I should be able to manage this timeline. With the f=
lexibility to extend the program, it should be even easier to accommodate a=
ny potential scheduling conflicts.
> +
> +
> +## Availability
> +
> +I will respond to all communication daily and will be available througho=
ut the duration of the program. Although I will be taking some summer cours=
es at my university, I will not be enrolled in a typical full course load. =
As part of GSOC, I plan to commit to 175 hours. I have experience managing =
my time effectively while taking courses and working full-time internships =
in the past. My semester ends on August 15th, and I have no commitments for=
 the following month, which allows me to continue working beyond the end of=
 the semester. With the flexibility to extend the timeline of GSOC, I am co=
nfident that I will have ample time to complete the project. I have already=
 discussed this with Victoria, the mentor for the project, and she has agre=
ed to extend the deadline until October 2nd, if necessary. After August 15t=
h, I will be able to work at least 8 hours per day, totaling ~360 hours of =
work until the October 2nd deadline. This exceeds the required commitment o=
f 175 hours, ensuring that I will complete the project on time. Additionall=
y, I am hoping to continue working on the project even after GSOC ends.
> +
> +# After GSoC
> +
> +I recognize the value of having our GSoC participants continue to engage=
 with our community beyond the event. This is why I am committed to doing s=
o myself. Participating in open-source projects, especially with a communit=
y that supports a widely-used development tool, is not only cool but also o=
ffers an opportunity to learn and grow. By continuing to participate in thi=
s community, I believe that I can make important contributions and continue=
 to develop my skills.
> +
> +I am planning to establish an open source club at my university in the n=
ear future. The University of Waterloo is known for its strong emphasis on =
computer science and engineering, earning it the nickname "MIT of the North=
." Given this, I believe that there will be a great deal of interest in the=
 club for a variety of reasons. Currently, there is another club called Blu=
eprint that provides a valuable opportunity for real-world development expe=
rience through developing software products for charities. However, the ent=
ry process for this club is extremely competitive. By contrast, I think tha=
t an open source club would offer a similar experience but with a lower bar=
rier to entry, thus making it accessible to more motivated students. Additi=
onally, given the widespread use and vibrant community of Git, I plan to di=
rect students to this community and am confident that many will be interest=
ed in contributing to its open source projects.
> +
> +# Some Credits to Myself
> +
> +I=E2=80=99ve previously completed three software developer internships a=
nd worked with small startups to large sized companies. I am currently inte=
rning with Morgan Stanley and am on the architecture team, working on a lar=
ge scale equity management software.
> +
> +I'm interested in open source development as a way to give back to the c=
ommunity while also growing as a developer. My background in C programming =
language has made me particularly interested in contributing to Git, which =
is primarily written in C. I am also comfortable with concepts like memory =
allocation, thanks to my experience with C programming. Furthermore, I have=
 studied shell scripting as part of my coursework, which makes me well-equi=
pped to handle the project's language requirements. Another personal motiva=
tion for contributing to this project is that I have worked with monorepos =
before, and given that it is used by many of the larger tech companies, I w=
ant to learn more about it and help improve the user experience with it.
> +
> +Victoria mentioned that I was the first person to express interest in th=
e project this year, either directly or via the mailing list. In my spare t=
ime, I've been contributing and reading documents while also working a full=
-time job (internship) and taking one course at my university. I expect to =
have a lot more time next term, so you can expect even more from me ;). Non=
etheless, I became familiar and comfortable with the contribution process b=
y writing, responding to, and auditing various types of patches in the comm=
unity.
> +
> +With the patches I have submitted so far, I have been able to develop a =
deeper understanding of Git internals, project structures, commonly used AP=
Is, test suites, required tech stacks, and coding guidelines. To further en=
hance my comprehension of Git, I have either read or skimmed through severa=
l relevant documents, including 'Submitting patches', 'Coding guidelines', =
'Myfirstcontribution.txt', 'Git tutorial', 'Git everyday', 'readme', 'Hacki=
ng Git', drawing upon my prior knowledge where applicable. Additionally, I =
have been referring to the book 'Pro Git' on an as-needed basis. Furthermor=
e, I have thoroughly read and referenced blogs such as 'Make your monorepo =
feel small with Git's sparse index', 'Bring your monorepo down to size with=
 sparse-checkout', and 'Commits are snapshots, not diffs'. The advantage of=
 having prior knowledge and experience with my proposed project idea is tha=
t I am well-prepared to tackle any upcoming challenges.
> +
> +# Closing remarks
> +
> +I am very motivated for this project because I have previously worked wi=
th monorepos and will most likely have to work with them again in my future=
 internships. As a result, I intend to continue working on remaining comman=
ds after GSOC whenever I have free time.
> +
> +I'd like to state that I'm a genuinely enthusiastic open-source newcomer=
 who is very much looking forward to this opportunity. I am grateful for th=
e opportunity to contribute to Git's development, and I am committed to wor=
king diligently to strengthen the open-source ecosystem. My ultimate goal i=
s to use this opportunity to bring new energy and ideas to the table, and t=
o make meaningful contributions that benefit the entire community.
> +
> +I am grateful for the community's support, especially Victoria's guidanc=
e and feedback. She promptly replied to my inquiries and provided me with s=
everal resources that were instrumental in helping me get started on the pr=
oject. I am truly humbled by the dedication and hard work that the communit=
y puts in to nurture and enhance this ecosystem, and I feel fortunate to ha=
ve received such warm and welcoming support as a new contributor. It is an =
honor to be a part of this community and to work towards advancing its miss=
ion.
> +
> +Thank you so much for reading through my proposal!
> +
> +Kind Regards,
> +Vivan Garg
> +
>
> base-commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
> --
> 2.37.0 (Apple Git-136)
>
