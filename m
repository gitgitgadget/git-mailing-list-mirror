Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DCAD2E4
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 08:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BX2hZcCN"
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA894EA
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 00:06:08 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50931355d48so7207610e87.3
        for <git@vger.kernel.org>; Tue, 07 Nov 2023 00:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699344367; x=1699949167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx97C4BGHX4Eu0oA/0ajBpV3Wiw+61XEhTjSEtdtKGo=;
        b=BX2hZcCNcnAX1jLP2dOgl2Wk2L18ngz3x0QH5EOlGxzp+XGG7S52C/ZttcMf7GHQeW
         2vjbvm090S2EfBZlwOFFtVoLZGshdHbGPDv/vhes7Mm1LdPqZqmOdVP+VZvaFKrqB1k7
         0ItAkls56lpBlHsTx1v9j+2iAOQTWWdZYyTMXZaHeEIXEM/yH4bHYaevUdCsE2SIzfPo
         5NUgOyTEYDuqQr2Ro+8wiFC74woWgnwJGfFrWzlQcLUaygDytrVG1onwZ1j2TK0YmBVp
         mlxoaMXw5WeUdudztlw6vWg5O/wVvKI0gJyYUWeJJGeJjBppeR/+nIv0j8V71hRA0me6
         dRdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344367; x=1699949167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vx97C4BGHX4Eu0oA/0ajBpV3Wiw+61XEhTjSEtdtKGo=;
        b=fyEej/dmCrxDE48yW+oXSNEIgic7CMfjdnOrdhgLk72I9Z2PuZL3haYGLcgnAi1YSh
         UtUVViACwLKnltBKusp5hOmZzk9ZR2/z93w4W4QdhDFjmCbhWGwzHzw5oN7DvzH8lDai
         gDslWelizmgG3V8aM8oMto8VT6oxs1DB2rPnQbLVPaIa4aChXB9HkQDWgIrROspneHgh
         Yo5r6f3AMo2LRDDAYc0L5l0kQBqVgDS6z++xbw9LENp1AiJmEFhtmlk3RXFMysk9aUyv
         fOwcTiNeihB0bxe8QcMHJ9dXgfM+LvnFHBWmGa7SAIgW6KnT3HHzZiVVvaoktXxs0KTK
         mKwg==
X-Gm-Message-State: AOJu0YyXrknG62Q3Js1sdCuxDO4f73n1Us9VtXKuaYVKm8H8PYnu3CkR
	2E9TnX0HGpjoGblnDyqprJ9x1jjFIPAs8qXS1BiU0nnK27c2WA==
X-Google-Smtp-Source: AGHT+IFPQDmGKcCP2Bg2X3pnn9If9ZsMOH4qNFdC1avseaUqrkDOQGs+nDYC35tpQvpJbzdAL32S+CClPMK8u5rbEXg=
X-Received: by 2002:a19:6416:0:b0:507:9702:8e09 with SMTP id
 y22-20020a196416000000b0050797028e09mr22282576lfb.2.1699344366690; Tue, 07
 Nov 2023 00:06:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <LO6P265MB6736043BE8FB607DB671D21EFAAAA@LO6P265MB6736.GBRP265.PROD.OUTLOOK.COM>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 7 Nov 2023 00:05:54 -0800
Message-ID: <CABPp-BHYaxa7QoXabM=7hW-93hQLK-=KayGtDHtWxxdAnJCcJw@mail.gmail.com>
Subject: Re: Git Rename Detection Bug
To: Jeremy Pridmore <jpridmore@rdt.co.uk>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>, Paul Baumgartner <pbaumgartner@rdt.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 6, 2023 at 4:01=E2=80=AFAM Jeremy Pridmore <jpridmore@rdt.co.uk=
> wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.

I think it might be worthwhile to point out a few facts about rename
handling in Git, as background information that might clarify a few
things about how Git's mental model seems to differ from yours:

  * In git, renames are not tracked; they are detected (based on file
similarity of the commits being compared).
  * So, when you run "git mv A B", there is no rename recorded.  It's
basically the same as "git rm A", followed by creating B with the same
contents, followed by "git add B".
  * The detection happens whenever an operation (diff, log -p, merge,
status, etc.) needs or wants to know about renames.
  * In git, directory renames are detected _after_ normal renames, and
via amalgamation of the individual renames.
  * As a corollary of the last item, the only way individual renames
can be affected by directory renames, is if the individual rename on
one side of history was into a directory that the other side of
history renamed away; in such a case, we apply an _extra_ rename to
move it into the new directory.  But we don't "undo" individual
renames to make them fit the majority-determined directory rename or
anything like that.

(Also, if it matters, all of this is true of both `recursive` and
`ort` merge strategies, i.e. the old default merge backend and the new
one.)

> What did you do before the bug happened? (Steps to reproduce your issue)
> I have two GIT repositories (A and B). Both migrated from the same TFS se=
rver using git-tfs tool. I migrated code into A and made lots of changes, i=
ncluding moving 50,000+ files from folder "/Landscape" to "/Landscape/src".=
  B contains the same code but with various other changes made since my ori=
ginal migration from TFS to A.  All the files in B are still in the "/Lands=
cape" folder.  I recently needed to merge my changes from A to B, so I adde=
d A as a remote to B and then performed a number of cherry-picks from A to =
B, but got stuck when trying to cherry-pick the commit containing the resul=
ts of moving all files into "/Landscape/src".

In case anyone else wants to dig into this, note that this problem
setup precludes directory rename detection being involved.  Directory
rename detection has a rule where if the source directory wasn't
entirely removed on one side, then that directory was not renamed on
that side.  Seems obvious, but the upshot of that rule is that a
directory cannot be renamed into a subdirectory of itself, because by
virtue of being a subdirectory that means its parent directory still
exists.

So, this is a problem where only regular rename detection (i.e. rename
detection of individual files) is going to be at play.

> What did you expect to happen? (Expected behavior)
> I expected the git rename detection to match all files in A "/Landscape" =
to files in B "/Landscape/src".

Are all files under "/Landscape" from the merge base commit
individually more similar to the counterpart under "/Landscape/src"
than to files under any other directory?  If not, the expectation goes
against how rename detection has worked in git from the beginning.

> What happened instead? (Actual behavior)
> Although many files were matched successfully, git mismatched over two do=
zen similarly named files, e.g.
>
> Incorrect path match: Landscape/Services/uiServices/Complaints/Interfaces=
/IAccountsIntegration.vb -> Landscape/src/Complaints/Rdt.Complaints.UI/Inte=
rfaces/IAccountsIntegration.vb
> Incorrect path match: Landscape/Services/uiServices/Complaints/Interfaces=
/IDocumentIntegration.vb -> Landscape/src/Complaints/Rdt.Complaints.UI/Inte=
rfaces/IDocumentIntegration.vb
> Incorrect path match: Landscape/Deployment/PowershellScripts/pre-req/Rdt.=
BatchProcessingService.Setup/pre-req.ps1 -> Landscape/src/Deployment/Powers=
hellScripts/pre-req/Landscape.Net/pre-req.ps1
> Incorrect path match: Landscape/Deployment/PowershellScripts/pre-req/Work=
flow/pre-req.ps1 -> Landscape/src/Deployment/PowershellScripts/pre-req/Rdt.=
BatchProcessingService.Setup/pre-req.ps1
> Incorrect name match: Landscape/Documentation/Rdt.Documentation.UI/Proper=
ties/licenses.licx -> Landscape/src/Deployment/PowershellScripts/pre-req/Wo=
rkflow/pre-req.ps1
> Incorrect path match: Landscape/Documentation/uiDocumentation/licenses.li=
cx -> Landscape/src/Documentation/Rdt.Documentation.UI/Properties/licenses.=
licx
> Incorrect path match: Landscape/Import/uiImport/My Project/licenses.licx =
-> Landscape/src/Documentation/uiDocumentation/licenses.licx
> Incorrect path match: Landscape/Main/uiMain.Workflow/My Project/licenses.=
licx -> Landscape/src/Import/uiImport/My Project/licenses.licx
> Incorrect path match: Landscape/Main/uiMain/My Project/licenses.licx -> L=
andscape/src/Main/uiMain.Workflow/My Project/licenses.licx
> Incorrect path match: Landscape/LandscapeApiService.Setup/Setup/UIContent=
/RDT_Logo.ico -> Landscape/src/Main/uiMain.Workflow/Resources/RDT_Logo.ico
> Incorrect path match: Landscape/Policy/Rdt.Policy.UI.Templates/Properties=
/licenses.licx -> Landscape/src/Main/uiMain/My Project/licenses.licx
> Incorrect path match: Landscape/Main/uiMain.Workflow/Resources/RDT_Logo.i=
co -> Landscape/src/Main/uiMain/Resources/RDT_Logo.ico
> Incorrect path match: Landscape/Policy/Rdt.Policy.UI/Properties/licenses.=
licx -> Landscape/src/Policy/Rdt.Policy.UI.Templates/Properties/licenses.li=
cx
> Incorrect path match: Landscape/Rates/uiRates/My Project/licenses.licx ->=
 Landscape/src/Policy/Rdt.Policy.UI/Properties/licenses.licx
> Incorrect path match: Landscape/Rdt.Claim.UI/Properties/licenses.licx -> =
Landscape/src/Rates/uiRates/My Project/licenses.licx
> Incorrect path match: Landscape/Rdt.Landscape.UI.Templates.Workflow/Prope=
rties/licenses.licx -> Landscape/src/Rdt.Claim.UI/Properties/licenses.licx
> Incorrect path match: Landscape/Rdt.Landscape.UI.Templates/Properties/lic=
enses.licx -> Landscape/src/Rdt.Landscape.UI.Templates.Workflow/Properties/=
licenses.licx
> Incorrect path match: Landscape/Rdt.Landscape.UI.Workflow/Properties/lice=
nses.licx -> Landscape/src/Rdt.Landscape.UI.Templates/Properties/licenses.l=
icx
> Incorrect path match: Landscape/Rdt.Landscape.UI/Properties/licenses.licx=
 -> Landscape/src/Rdt.Landscape.UI.Workflow/Properties/licenses.licx
> Incorrect path match: Landscape/StandardLetters/uiStandardLetters/My Proj=
ect/licenses.licx -> Landscape/src/Rdt.Landscape.UI/Properties/licenses.lic=
x
> Incorrect path match: Landscape/Complaints/Rdt.Complaints.UI/Interfaces/I=
DocumentIntegration.vb -> Landscape/src/Services/uiServices/Complaints/Inte=
rfaces/IDocumentIntegration.vb
> Incorrect path match: Landscape/SystemEvents/uiSystemEvents/My Project/li=
censes.licx -> Landscape/src/StandardLetters/uiStandardLetters/My Project/l=
icenses.licx
> Incorrect path match: Landscape/Services/busServices/RDT_Logo.ico -> Land=
scape/src/Startup/uiStartup.Workflow/Resources/RDT_Logo.ico
> Incorrect path match: Landscape/Startup/uiStartup.Workflow/Resources/RDT_=
Logo.ico -> Landscape/src/Startup/uiStartup/Resources/RDT_Logo.ico
> Incorrect path match: Landscape/Startup/uiStartup/Resources/RDT_Logo.ico =
-> Landscape/src/Startup/uiStartup32/RDT_Logo.ico
> Incorrect path match: Landscape/Startup/uiStartup/Resources/newrdlogograd=
iant48shad.ico -> Landscape/src/Startup/uiStartup32/newrdlogogradiant48shad=
.ico
> Incorrect path match: Landscape/Templates/uiTemplates.Workflow/My Project=
/licenses.licx -> Landscape/src/SystemEvents/uiSystemEvents/My Project/lice=
nses.licx
> Incorrect path match: Landscape/Utils/Rdt.Utils.UI/Properties/licenses.li=
cx -> Landscape/src/Templates/uiTemplates.Workflow/My Project/licenses.licx
> Incorrect path match: Landscape/Utils/uiUtils/My Project/licenses.licx ->=
 Landscape/src/Utils/Rdt.Utils.UI/Properties/licenses.licx
> Incorrect name match: Landscape/WebServices/ServiceFabric/Policy/Rdt.Poli=
cy.Repository.Service.Fabric.Host/PackageRoot/Data/Swagger/Examples/POST_UK=
STasks_Response.json -> Landscape/src/Utils/uiUtils/My Project/licenses.lic=
x
>
>
> What's different between what you expected and what actually happened?
>
> As you can see, although the filenames (and content) are the same,

The content is the same as well?  So, these renames that you label as
incorrect are actually _exact_ renames -- and further, in most cases
they also have an identical basename for the file as well.

Exact renames are detected first, before any other method of rename
detection is employed, and other than giving a preference to files
with the same basename, if there are multiple choices it just picks
one (what I'd call at random, though technically based on what the
internal processing order happens to be; see the "Too many identical
alternatives? Pick one" code comment).

And this, too, is true of both the `recursve` and `ort` backends; no
change has been made to how exact renames are handled.

>  In some cases, it seems that the catalyst has been git thinking that a f=
ile from B has been deleted from A, when in fact it has not actually been d=
eleted at all.
>
> For example, the file Landscape/Deployment/PowershellScripts/pre-req/Land=
scape.Net/pre-req.ps1 has not been deleted in A or B, therefore git should =
not have attempted to rename Landscape/Deployment/PowershellScripts/pre-req=
/Rdt.BatchProcessingService.Setup/pre-req.ps1 to Landscape/Deployment/Power=
shellScripts/pre-req/Landscape.Net/pre-req.ps1, especially as it then attem=
pts to rename Landscape/Deployment/PowershellScripts/pre-req/Workflow/pre-r=
eq.ps1 to Landscape/src/Deployment/PowershellScripts/pre-req/Rdt.BatchProce=
ssingService.Setup/pre-req.ps1 and so on.

Renamed files, from Git's perspective, always involve files that have
been deleted.

> Git status contains, for example:
>         deleted by them: Landscape/Deployment/PowershellScripts/pre-req/L=
andscape.Net/pre-req.ps1

This means that it wasn't sufficiently similar to any of the new
files...or that _other_ deleted files were more similar to the new
files and thus that they were paired up instead of this file, leaving
this file to simply be marked as deleted.  (Or that other deleted
files were just as similar; tie-breakers are kinda random in such a
case.)

[...]

> Anything else you want to add:
> I can't help but think that this is related to changes made by Palantir:
> https://blog.palantir.com/optimizing-gits-merge-machinery-1-127ceb0ef2a1

Curious.  What makes you think it's related?

If there is some reason you think it's related, there's an easy way to
check -- just repeat the cherry-pick with the "-s recursive" flag to
use the old merge backend and compare the results.

I'll be somewhat surprised if it's related, though.

> I have tried to unstage these renames using "git restore --staged <file_n=
ame>" so I can then apply the correct "git mv" commands

Why?  Just modify all the files to have the correct end results and then co=
mmit.

>, but bizzarely, this then results in "git status" reporting a different, =
smaller set of mismatched names:

As mentioned earlier, git does _not_ record renames.  So, running the
correct "git mv" command doesn't really mean much.  If you use
completely "incorrect" git-mv commands, but then manually tweak files
until they have the correct results, then what's recorded is exactly
the same as if you had used the "correct" git-mv commands.

Further, when you run "git status", it can't access any renames you
did because that information isn't recorded anywhere.  It instead
recomputes renames on the fly.  And it does so each and every time you
run "git status", even if you make no changes between two invocations.
In fact, from this you can probably also deduce that there are other
ways to affect what will be shown as renames, when you have multiple
files similar to any given source file.  In particular, you can cause
a different pairing modifying one of the similar files enough that it
becomes the most similar to the source file, or so that it becomes no
longer the most similar to the source file.  However, what "git
status" reports for renames is irrelevant, since that info won't be
recorded in the commit.  Renames are never recorded.  Anywhere.

In fact, you can even run "git status --no-renames" to just see the
old filenames that were removed and the new ones that were added
without having all the files be paired up as renames.



Hope that helps,
Elijah
