Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E32DA775
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 18:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167110; cv=none; b=lRBm9v6+gIcW8uvhSJ1/jfASYq4nZqrmUXQHqMzZBAChx4pHs9KLSs90KRzQAeAYihSagBVMHEF0p2aen/HW+wkNFkJhdWDwRt4AVeh1vuyqQnZ1Bt7RGj428Sn5ODrkLVwarFwdSY+HZ7JjwZvX8sj1HL5DgnIlLH4jvwg7g40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167110; c=relaxed/simple;
	bh=l5+ZQGLInKmnW2RkaykgMrSVmsjkg6vvJ6Lv6jj1dQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dDN+JhEdy0We25mxPczpvGy7X7D2llfwYI9rU5CuYici7WYnrAfq7jJtlX0B4NqVw9GeOqbl5mh1zT/zmVvpk5WroZC/X8f7Awe6asZL3NxwTqPhO595Lcugtcl9NBxfRozCoJJDeqHCdahpMuNOSR0fYlyj3g785Z1pf8NOzKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbsDDhra; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbsDDhra"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48534237460so32585675e9.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773167106; x=1773771906; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oa+GLyPqlwc+4GUFveUe0gJDn7dh9crvjC9otrJdcHI=;
        b=gbsDDhraH9cmX04EIi3ZYe0RZwplspP45sILpTUfEgYDwPY6RIRZQUqghSCDyDAk0b
         zjz85/4b84SJdrJCL9zIEQctWUo+tgZwrDJ+sLhZ8cVFwHMyCySYfAtorVX1uGGAjP4Z
         Tnq9pTiVt7jpQXK0FIK0xIsjXc7ROo0GDnLUuA4iRz/e0Ahl9A952UgfU+kVUualQewx
         vW2Pceqr4qXVgyWrdSjbljKPtrC8sV4oi6JSB0esaZejMs1KzZwU5++mxu8JZIKeHVPB
         b6IBNMUBSrg/P+NzkyT8bNH5ZUKPcNl81UV9jXvvXBpYpzgTkcLuKut+BQ2wdSoXMdIJ
         Xi3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167106; x=1773771906;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oa+GLyPqlwc+4GUFveUe0gJDn7dh9crvjC9otrJdcHI=;
        b=TzdzL/BTqjbWBNmxVZ1wYzOn5JcBZfRsrzyVaHt5RaenT+VS2D64NoPoQL/LYUMWcf
         249WUJDylK5mkS7EA+Gu2+hwwqepooTli4xrW602CaDE49F59LOLQpKZJNEzxAqh2Ovv
         pM6RNx8WYwgQUmXi95dTaX2cSJYFKcbMH+VeFiRTbbZCSZkv/sg1ytDviSogTrWWxEkr
         eePIuNPTq4FtXGMi0uxI+sZfXDw4sk4emZbJgYLftxaMampWKLXhvVEyS8rcttLGVRom
         Bvs4/dVIxJrGHbALQKQBzdWYfMhfyewV9SNrbzTpMXVE8XUsRxREkbA1epQhO6J/63EY
         lI8A==
X-Gm-Message-State: AOJu0YzYUdCLMjask8Lnd6T0cyeZEQ734f/HbGOci5vsptT7M2O8y3by
	NRxLid37jDBVND7B8Sl0xPip7ImGitjyGlDmGTNR31iZCLF8w9wHYcPEv2QzdA==
X-Gm-Gg: ATEYQzyEkGz5xsL67JEcbZ5JGcILxrs/VgKctCTRNL63WwIEf7YI5dj+jvp8kn2+GYs
	rgceX6aica/8abKmLrogYv7UUuLIYK+ffTxp1lVMyH+1QMEI4QKwLYSwzCcTVHUWYhOj/HmN2XX
	1K+IMSaco/Q3EHbJb5zqINML0Az8mZQbaLsTxuW/eUlwVk790xTuMNzcgJ98Ws4IljkrGLWSGWg
	oHW0xw3+XrKLXbQCnE7nAVKzGShYyo41UzKm/TDCPqhBoovjLRAitXHiORcl78K1u+zKTcMKeP7
	RZ17sKuBKwKcODklx+ikmnfV9aXTYfQH90gF7PaKDQT0KvgAhrVUxz3d4S0/YY62JBUYlQs0Seb
	CTdeVD+88k+32OjCObkJwYYi5SzCnhEJOncySTCCoZWJpian/1bhiHZgfyalQFmHEVlU0WErvc8
	Is5+++lqG/2Xnl7bOZFF63wdjeXbA/mFaL
X-Received: by 2002:a05:600c:5250:b0:485:2fe9:3375 with SMTP id 5b1f17b1804b1-4852fe93587mr219039115e9.15.1773167105657;
        Tue, 10 Mar 2026 11:25:05 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a900easm106022155e9.9.2026.03.10.11.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 11:25:05 -0700 (PDT)
Date: Tue, 10 Mar 2026 19:25:03 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [GSoC Proposal] Implement promisor remote fetch ordering
Message-ID: <abBh__zmlWXY-yjI@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following is my proposal for the GSoC'26 for the project "Implement
promisor remote fetch ordering".

As soon as the the contributor application period begins, I will submit
the proposal in PDF format to the official GSoC website.

I have dedicated a large section (about 40%) of the proposal to
explaining the current situation and the tests that I have done to gain a
lot of hands-on experience. I consider this section important, but if it
too long-winded, please let me know.

Thank you so much to everyone that is going to spend their time reading
this proposal and giving me their feedback.


==============================

"Implement promisor remote fetch ordering"

==============================


# Personal information

Name: Lorenzo Pegorari
Pronouns: he/him
Location: Cremona, Lombardy, Italy
Timezone: CET (UTC+1)
Email: lorenzo.pegorari2002@gmail.com
GitHub: https://github.com/LorenzoPegorari
LinkedIn: https://www.linkedin.com/in/lorenzopegorari/

------------------------------

# Background

## General

Hi Git team! My name is Lorenzo Pegorari and I am a 23-year-old student
from Italy.

Throughout my undergraduate studies, I constantly tried to differentiate
myself by taking part in as many interesting experiences as possible, to
better define my future professional path. And so, at the end of 2024, I
decided to join the FOSS world in order to improve my software
engineering skills and to contribute to projects that I find meaningful.

My goal is to join the broader Linux community, mostly focusing on the
Linux kernel and Git, and to prove to myself that I am capable of
participating in prestigious (and, in the context of the GSoC,
competitive) organizations. My dream is to one day become a cornerstone
in one of these open-source communities.

## Education

I am currently in the final year of my BSc in Computer Science and
Engineering at Politecnico di Milano (Milan, Italy).

## Previous Open-Source Experience

I am fairly new to contributing to open-source projects, which is why I
am applying for the Google Summer of Code in the first place.

My first step in the open-source world happened on October 16th 2024,
when I released my first project Simply Colorful [1], a free theme for
the note-taking application Obsidian that has now gathered close to 10000
downloads since its release.

Last year, in the summer of 2025, I also had the honor of participating
in the Google Summer of Code 2025 with the organization BRL-CAD, where I
successfully completed my proposed project "Developing a MOOSE-based
Console for arbalest: a first step to merge arbalest and qged" [2].

The general goal of the project was to take the initial step in merging
BRL-CAD's two in-development GUIs: "arbalest" and "qged". The primary
objective was to transfer qged's sophisticated GED (Geometry EDiting)
console, which works via low-level calls to BRL-CAD's core libraries,
into arbalest, while preserving the application's distinctive clean and
easy-to-scale architecture. To support this endeavor, I also expanded
BRL-CAD's new lightweight, modular, object-oriented API, known as
"MOOSE". In addition to these core tasks, I also fixed some compatibility
issues related to arbalest's Qt6 widgets to ensure proper display across
different OSs, and resolved various GUI-related bugs.

More information regarding my previous GSoC participation can be found in
my final project report [3] and in my GSoC'25 daily notes [4]. I am also
extremely happy to say that my work was much appreciated by the BRL-CAD
community, with the organization admin Christopher Sean Morrison stating
that my final project report was "outstanding", and my amazing mentor,
Dr. Daniel Rossberg, noting that my performance was "awesome" and that I
was "a pleasure to mentor".

I would also like to state that, even though I have been quite busy
lately, I still consider myself a part of the BRL-CAD community, having
done some small fixes after the GSoC'25 ended, and now having personally
helped some new developers to (hopefully) join BRL-CAD for the GSoC'26.

## Git Experience

I joined the Git community at the beginning of 2026, but I have been
interested in this project since 2024. In fact, last year, when I was
deciding which organization to join the GSoC'25 with, I seriously
considered Git, but in the end I discarded it because I felt not skilled
enough to take part in such a complex organization. This time, though, I
feel much more confident, and so here I am!

Since the start of this year, I have explored the codebase as much as
possible, focusing on the GSoC project ideas regarding partial clones,
which were the ones that I personally found most interesting and valuable.

So far, I have made the following contributions to Git:

 * [GSoC PATCH v2] diff: improve scaling of filenames in diffstat to handle UTF-8 chars
   * Link: https://lore.kernel.org/git/cover.1768520441.git.lorenzo.pegorari2002@gmail.com
   * Description: The computation of column width made by `git diff --stat`
                  was confused when pathnames contained non-ASCII chars.
		  This issue was reported by a `NEEDSWORK` comment.
   * Status: Merged to `master`
 
 * [GSoC PATCH v3] diff: handle ANSI escape codes in prefix when calculating diffstat width
   * Link: https://lore.kernel.org/git/cover.1772226209.git.lorenzo.pegorari2002@gmail.com
   * Description: Fixed `git log --graph --stat` not correctly counting
                  the display width of colored graph part of its own
		  output. This issue was reported by a `NEEDSWORK` comment.
   * Status: Merged to `master`.
    
 * [GSoC PATCH v3] doc: improve gitprotocol-pack
   * Link: https://lore.kernel.org/git/cover.1772502209.git.lorenzo.pegorari2002@gmail.com
   * Description: Improved the `gitprotocol-pack` documentation.
   * Status: Will merge to `master`.

## Experience With C

C is my primary language. I used it throughout my university courses, for
most of my personal projects, and during my GSoC'25 project with BRL-CAD,
where, although my main tasks involved using C++ and Qt6, I had to
constantly interface with BRL-CAD's core libraries, which are written in C.

------------------------------

# Current Situation & Testing

## Partial Clones

The "partial clone" feature was introduced to better handle extremely
large repositories, particularly those that contain large binary files.
The problem is clearly shown with the following example, which
illustrates how quickly the size of a Git repository can grow when just
one single 1 MB binary file is frequently committed:

```
#!/bin/bash
git init size_check
# Create 1MB file of random data, to simulate a compressed binary
head -c 1M </dev/urandom >size_check/foo 
git -C size_check add foo
git -C size_check commit -m "foo"
du -hs size_check/.git/objects  # .git/objects size after 1 foo commit = 1.1 MB
for i in {1..50}; do
    head -c 1M </dev/urandom >size_check/foo  # Change the 1MB file
    git -C size_check commit -a -m "foo"
done
du -hs size_check/.git/objects  # .git/objects size after 51 foo commits = 53 MB
```

Partial clones avoid this issue during `clone` and `fetch` operations by
passing all the objects to download through a `--filter=<filter-spec>`
specified by the user, which will limit the number of blobs and trees
that actually get downloaded. The `<filter-spec>`, can, for example, be:
 * `blob:none`, which will filter out all blobs.
 * `tree:0`, which will filter out all trees.
 * `blob:limit=5k`, which will filter out all blobs whose size is greater
   than $5$kB.

The filtered out objects will be lazily downloaded when the user runs a
command that requires those missing data.

This mechanism works with the following steps:
 * When the client wants to fetch some objects from the server using a
   filter, the client, after sending a list of capabilities it wants to
   be in effect, sends the `filter: <filter-spec>` capability, followed
   by a request for the objects that the client wants to retrieve. The
   following is an example of a request (extracted using
   `GIT_TRACE_PACKET=1`) made by a client to a server to fetch 1 object
   using the `<filter-spec>=blob:none`:

   ```
   [...]
   pkt-line.c:85           packet:        fetch< 0000  # "flush-pkt"
   pkt-line.c:85           packet:        fetch> command=fetch  # Execute fetch
   pkt-line.c:85           packet:        fetch> agent=git/2.43.0
   pkt-line.c:85           packet:        fetch> object-format=sha1
   pkt-line.c:85           packet:        fetch> 0001  # "delim-pkt"
   pkt-line.c:85           packet:        fetch> thin-pack  # Capability
   pkt-line.c:85           packet:        fetch> no-progress  # Capability
   pkt-line.c:85           packet:        fetch> ofs-delta  # Capability
   pkt-line.c:85           packet:        fetch> filter blob:none  # Filter capability
   # OID of the object the client wants to retrieve
   pkt-line.c:85           packet:        fetch> want 394ca7a7b5e75a57e736040480f685c8b71844eb  
   pkt-line.c:85           packet:        fetch> done  # End fetch
   pkt-line.c:85           packet:        fetch> 0000  # "flush-pkt"
   [...]
   ```

 * The server will apply the requested `<filter-spec>` as it creates the
   "promisor packfile" of the requested objects. A packfile is a binary
   file that is used to compress many "loose objects", and it does so by
   containing the most recent versions of the stored objects and deltas
   of the previous versions of those objects. A promisor packfile is a
   filtered packfile, where the unwanted objects are not present. The
   promisor packfile is sent to the client.

 * When the client receives the promisor packfile, it can operate
   normally by knowing that the "promisor objects" (the filtered-out
   objects) will be dynamically fetched when needed from "promisor
   remotes" (remotes that have "promised" that they have the missing
   objects). The promisor remotes are defined using the
   `remote.<name>.promisor` and `remote.<name>.partialCloneFilter`
   configuration variables.

## Multiple Promisor Remotes & Testing

Focusing on promisor remotes, currently multiple of them can be
configured and used. This feature gives users the flexibility to use a
specific promisor remote when convenient (e.g., a remote that is
closer/faster for some kind of object). This is particularly useful when
working with extremely large repositories ($+100$GB) that contain many
large binary files. These types of repositories can greatly benefit from
having multiple promisor remotes: a common example is setting them up so
that one promisor remote can act as a "Large Object Promisor" (LOP),
meaning a remote that is used only to store large blobs, while the other
one will be the main remote, used to store everything else.

I created a minimal example setup, mostly based on the test
`t/t5710-promisor-remote-capability` added by `4602676` ("Add
'promisor-remote' capability to protocol v2", 2025-02-18), to experiment
with multiple promisor remotes, in order to not simply rely on the
documentation, but to actually get hands-on experience. The example setup
creates a `server`, a 'lopm' ("Large Object Promisor medium") for blobs
larger than 5kB, a `lopl` ("Large Object Promisor large") for blobs
larger than 50kB, and a `client` that interfaces with all of these
remotes. It is created in the following way:

 * Initially, a very simple Git repository `template` is created, which
   contains just 3 commits, 3 trees, and 3 blobs of different sizes (as
   shown by using `git verify-pack -v`:

   ```
   # "git -C template verify-pack -v *.pack" output:
   <OID-commit-large> commit 217 157 12
   <OID-commit-medium> commit 218 159 296
   <OID-commit-small> commit 169 127 169
   <OID-tree-large> tree   102 105 455
   <OID-tree-medium> tree   69 76 606
   <OID-tree-small> tree   35 46 560
   <OID-blob-large> blob   102400 102444 682  # 100kB blob
   <OID-blob-medium> blob   10240 10254 103126  # 10kB blob
   <OID-blob-small> blob   6 15 113380  # 6 bytes blob
   non delta: 9 objects
   <*.pack>: ok
   ```

 * The bare `server`, based on the `template`, and the bare and empty
   `lopm` and `lopl`, are generated using, respectively, `git clone
   --bare --no-local template server` and `git init --bare lop[m|l]`.
 
 * The objects inside the `server` are unpacked, with all blobs larger
   than 5kB copied inside `lopm` and all blobs larger than 50kB copied
   inside `lopl`. The `server` is then repacked using the command `git
   repack -a -d --filter=blob:limit=5k` (to remove blobs larger than
   5kB), and finally a ".promisor" file is created with the same name as
   the ".pack" file, to tell Git that all missing objects from the pack
   can be found in the configured promisor remotes.

 * The `server` configuration is modified to support `lopm` and `lopl` as
   promisor remotes. Also, make it so that inside `server`, `lopm`, and
   `lopl`, `upload-pack` will support partial clone and partial fetch
   object filtering (using `uploadpack.allowFilter`), and will accept a
   fetch request that asks for any object at all (using
   `uploadpack.allowAnySHA1InWant`):

   ```
   git -C server remote add lopm "file://$(pwd)/lopm"  # Add lopm remote to server
   git -C server config remote.lopm.promisor true  # Make lopm a promisor remote
   git -C server remote add lopl "file://$(pwd)/lopl"  # Add lopl remote to server
   git -C server config remote.lopl.promisor true  # Make lopl a promisor remote
   git -C server config uploadpack.allowFilter true
   git -C server config uploadpack.allowAnySHA1InWant true
   git -C lopm config uploadpack.allowFilter true
   git -C lopm config uploadpack.allowAnySHA1InWant true
   git -C lopl config uploadpack.allowFilter true
   git -C lopl config uploadpack.allowAnySHA1InWant true
   ```

 * The `client` is created by doing a partial clone of the `server`, and
   adding `lopl` and `lopm` as promisor remotes: 

   ```
   GIT_TRACE=$(pwd)/trace \  # Env var to trace general messages
   GIT_TRACE_PACKET=$(pwd)/packet \  # Env var to trace messages for in/out packets 
   GIT_NO_LAZY_FETCH=0 \  # Env var to enable lazily fetch missing objects on demand
   git clone \
       -c remote.lopl.url="file://$(pwd)/lopl" \  # Add remote lopl
       -c remote.lopl.fetch="+refs/heads/*:refs/remotes/lopl/*" \
       -c remote.lopl.promisor=true \  # Make lopl a promisor remote
       -c remote.lopm.url="file://$(pwd)/lopm" \  # Add remote lopm
       -c remote.lopm.fetch="+refs/heads/*:refs/remotes/lopm/*" \
       -c remote.lopm.promisor=true \  # Make lopm a promisor remote
       --no-local --filter="blob:limit=5k" server client
   ```

Now, with this setup, by slightly tweaking the configurations of each
repository, it is possible to deeply test how multiple promisor remotes
are handled in various situations, and actually see what is described in
the documentation.

## Testing Promisor Remotes Advertisement

An important thing to test is the promisor remotes advertisement feature.
This feature is dependent on 2 main configuration options: the
server-side option `promisor.advertise`, which enables the server to
advertise the promisor remotes it is using to the client, and the
client-side option `promisor.acceptFromServer`, which describes how the
client should handle the promisor remotes advertised:

 * If `promisor.advertise=false`, when the `client` wants to fetch an
   object that the `server` does not have, the `server` will not
   advertise the `promisor-remote` capability, and so it has no other
   choice than to first fetch the object from `lopl` and/or `lopm`, and
   then give it to the `client`. This can be checked by doing `git -C
   server rev-list --objects --all --missing=print`, and seeing that the
   previously missing large blobs are now present inside the `server`, or
   by directly looking into the `GIT_TRACE_PACKET` output, and seeing
   that there is no reference to the `promisor-remote` capability.

 * If `promisor.advertise=true`, when the `client` wants to fetch an
   object that the `server` does not have, the `server` will advertise
   its promisor remotes, as seen by the `GIT_TRACE_PACKET` output, which
   will contain:
    
   ```
   [...]
   packet: upload-pack> promisor-remote= \
       name=lopl,url=file://$(pwd)/lopl; \  # Adv lopl
       name=lopm,url=file://$(pwd)/lopm  # Adv lopm
   [...]
   ```

   The `client` can control what advertised promisor remote to accept with
   the following options:

    * If `promisor.acceptFromServer=All`, the `client` will accept all
      advertised promisor remotes. This can be seen by looking at the
      `GIT_TRACE_PACKET` output, which will contain:
      
      ```
      [...]
      packet: clone> promisor-remote=lopl;lopm  # Accept lopl and lopm
      [...]
      ```
    
    * If `promisor.acceptFromServer=KnownName`, the `client` will accept
      promisor remotes which are already configured and have the same
      name. This can be seen by changing the `lopl` name in the `client`
      configuration, and looking at the `GIT_TRACE_PACKET` output, which
      will contain:
    
      ```
      [...]
      packet: clone> promisor-remote=lopm  # Accept lopm (no reference to lopl!)
      [...]
      ```
        
    * If `promisor.acceptFromServer=KnownUrl`, the `client` will accept
      promisor remotes which are already configured and have the same
      name and URL. This can be seen by changing the `lopl` URL in the
      `client` configuration, and looking at the `GIT_TRACE_PACKET`
      output, which will contain:
    
      ```
      [...]
      packet: clone> promisor-remote=lopm  # Accept lopm (no reference to lopl!)
      [...]
      ```

    * If `promisor.acceptFromServer=None`, the `client` won't accept any
      advertised promisor remotes.

Additional pieces of information can be sent by the server when
advertising its promisor remotes to the client. These pieces of
information are configured in the server-side configuration variable
`promisor.sendFields`, and currently can be:

 * `partialCloneFilter`, which contains the partial clone filter used for
   the remote.

 * `token`, which contains an authentication token for the remote.

The client-side configuration variable `promisor.checkFields` can be used
by the client to check if the values transmitted by a server correspond
to the values in its own configuration, and accept the promisor remote if
they are the same.

A simple test can be done by adding the `remote.lopl.partialCloneFilter`,
`remote.lopl.token`, and the `promisor.sendFields` variables to the
`server` configuration. The output of `LOG_TRACE_PACKET` will contain:

```
[...]
packet:  upload-pack> promisor-remote=name=lopl, \  # name field will always be sent
    url=file://$(pwd)/lopl, \  # url field will always be sent
    partialCloneFilter=blob:none, \  # partialCloneFilter field of lopl
    token=value; \  # token field of lopl
    [...]
```

Recently, with the patch series "Implement `promisor.storeFields` and
`--filter=auto`" [5], the new client-side configuration variable
`promisor.storeFields` was added. It contains a list of field names
`partialCloneFilter` and/or `token`), and the values of these fields,
when transmitted by the server, will be stored in the local configuration
on the client.

## Testing Multiple Promisor Remotes Fetch Order

Finally, the last mechanism that is fundamental to understand is the
fetch order when multiple promisor remotes are defined:

 * When multiple remotes are configured, they are tried one after the
   other in the order in which they appear in the configuration, until
   all objects are fetched. This can be easily seen from the output of
   `GIT_TRACE`, which initially tries to fetch the objects from `lopl`,
   and then from `lopm`:

   ```
   [...]
   trace: built-in: git fetch lopl [...] --filter=blob:none [...]
   [...]
   trace: built-in: git fetch lopm [...] --filter=blob:none [...]
   [...]
   ```

   While, if we make it so that we first define `lopm` in the `client`
   configuration, then initially `lopm` will be used to fetch the
   objects, and `lopl` will not be used at all (because `lopm` contains
   all required objects:

   ```
   [...]
   trace: built-in: git fetch lopm [...] --filter=blob:none [...]
   [...]
   ```

 * If the configuration option `extensions.partialClone` is present, the
   promisor remote that it specifies will always be the last one tried
   when fetching objects.
    
------------------------------

# "Implement promisor remote fetch ordering"

## Project Goal

This project aims to improve Git by implementing a fetch ordering
mechanism for multiple promisor remotes, that can be:

 * Configured locally by the client.
 * Advertised by servers through the `promisor-remote` protocol.

## Approach

The bulk of the project will be the creation of a system that allows to
define the order with which the promisor remotes will be tried when
fetching an object.

The first goal will be the creation of a `remote.<name>.promisorPriority`
configuration option, which will hold a number between 1 and 'UCHAR_MAX',
and which defines the priority of that promisor remote in the fetch
order. This means that the order in which the promisor are tried will be
the following:

 * All promisor remotes that have a valid `remote.<name>.promisorPriority`,
   starting from the one with higher priority (the lower `promisorPriority`
   value). If 2 or more promisor remotes have the same priority, they will be
   tried following the order in which they appear in the configuration file.

 * All promisor remotes that don't have or have an invalid
   `remote.<name>.promisorPriority` configuration option. If 2 or more
   promisor remotes don't define any priority, or have an invalid priority,
   they will be tried following the order in which they appear in the
   configuration file.

 * The promisor remote defined inside the `extensions.partialClone`, no
   matter their priority (which will be ignored if present). This is
   necessary for backward compatibility.
    
Having already taken a look at the code, I have a general idea of th
major steps to take to actually introduce the
`remote.<name>.promisorPriority` configuration option:

 * Modify the `promisor_remote` linked list (inside `promisor-remote.h`)
   to introduce the new member `promisor_priority}` and the
   `promisor_remote_config()` function (inside `promisor-remote.c`), to
   correctly fill the `promisor_priority` of all promisor remotes read
   from the configuration file.

 * Modify the `promisor_remote_get_direct()` function (defined inside
   `promisor-remote.c`), which fetches all requested objects from all
   promisor remotes, trying them one at a time until all objects are
   fetched, to make it follow the previously defined promisor remote order.

When the first goal is achieved, the client-side-only fetch ordering
mechanism for multiple promisor remotes, controllable locally from the
client configuration, will be complete.

The second goal will be the introduction of the new `promisorPriority`
field for the `promisor.sendFields`, `promisor.checkFields`, and
`promisor.storeFields` configuration variables. With this new field, the
server will be able to tell the priorities of the promisor remotes that
it advertises to the client, and the client will be able to either check
or store these suggested priorities.

My general plan to implement the `promisorPriority` field is the following:

 * Create the `static const char promisor_field_priority` variable inside
   `promisor-remote.c`, and add this variable inside the `known_fields` array.

 * Introduce the new member `priority` to the `promisor_info struct`, a
   structure for promisor remotes involved in the `promisor-remote`
   protocol capability, and the new member `store_priority` to the
   `store_info struct`, a structure used in the "store fields" mechanism.

 * Create the new `valid_priority()` function, which has to parse the
   value inside the `promisorPriority` field, and check if it is valid.

 * Modify many functions inside of the `promisor-remote.c` file to
   support the new field. Some of these functions are:

    * `promisor_remote_info()`
    * `set_one_field()`
    * `match_field_against_config()`
    * `all_fields_match()
    * `parse_one_advertised_remote()`
    * `store_info_new()`
    * `promisor_store_advertised_fields()`

When the second goal is achieved, the mechanism for servers and clients
to, respectively, advertise and check/store the promisor remote fetch
order will be complete.

# Possible Issues

From my understanding, the project as it is proposed will handle all
possible cases, except for one. Let's imagine the following situation:

 * `server1` and `server2` both use the promisor remotes `lop1` and `lop2`.
 * `client` has both `server1` and `server2` as remotes.

In this situation, the `client` has no way to specifically say that when
fetching from `server1`, it wants to first try `lop1` and then `lop2`, while
when fetching from `server2`, it wants to first try `lop2` and then `lop1`.

One way to solve this very specific (and maybe unusual) issue is to
introduce a way to associate a `promisorPriority` to a specific remote. 

## Development Schedule

Project size: large (350 hours).

Timeline:

 * May 01 - May 24 (Community Bonding Period):
    * Discuss with the mentor(s) the best plan to implement the new features.
    * Get familiar with the Git components that are required to implement the new features.
 * May 25 - June 14
    * Add the `remote.<name>.promisorPriority` configuration option.
    * Write tests for the new feature.
    * Update the documentation.
 * June 15 - June 28
    * Implement all the suggestions made by the mentor(s)/community.
    * Refine the patch series
 * June 29 - July 10
    * Complete all remaining work.
    * Submit the midterm project report for evaluation.
 * July 11 - August 02
    * Add support for the `promisorPriority` field.
    * Write tests for the new feature.
    * Update the documentation.
 * August 03 - August 16
    * Implement all the suggestions made by the mentor(s)/community.
    * Refine the patch series
 * August 17 - August 24
    * Wrap up everything that is still pending.
    * Submit the final project report for evaluation.

This development schedule can be subject to changes/corrections during
the "Community Bonding Period".

## Time Availability

I plan to spend 5-6 hours a day from Monday to Saturday on this projects,
so roughly around 30-36 hours a week.

I intend to keep a daily log of what I do, similar to what I have done
during the GSoC'25.

------------------------------

# Possible questions

## Am I eligible for the GSoC?

Yes. It is possible to participate for a second GSoC term as long as the
contributor is still a student.

## Will I use AI?

Mostly no. Most studies right now show that the use of LLM-assisted
coding, for junior developers, is detrimental in many ways: spending more
time on tasks, creating worse code, and learning less during the process.

Considering that my very first goal as a GSoC contributor is to use this
experience to learn as much as possible, I will not use AI for coding.

I will exclusively use AI to check for grammatical and/or syntactical
errors in sentences I have written. I will never use AI to generate text,
but only to double check it.

## What is my reasoning behind proposing a new feature?

As clearly stated in the "General Applicant Information" in the "Git
Developer Pages" [6], contributors suggesting new features should
carefully consider the many potential issues that may arise, and see if
they can be mitigated before the project is submitted.

My reasoning behind the proposal of this new feature is the following:

 * I think that in my proposal I have shown that I have considered
   thoroughly all possible cases regarding the introduction of the
   "promisor remote fetch ordering" feature, and so I feel that the
   necessary discussion to define the details of the project will be
   very quick.

 * I think the proposed new feature is not prone to long naming or user
   interface discussions.

 * I think that the "promisor remote fetch ordering" feature is a
   necessary step to fully support multiple promisor remotes, and to
   fully support the partial clone mechanism.

 * I think the proposed project is not too complex or too difficult for
   me to handle. In fact, although I was interested, I discarded the
   "enhance promisor-remote protocol for better-connected remotes" project
   idea, precisely because it seemed like a way too big and complex
   feature to handle for a GSoC project.

## Why Git?

As I have said already, I have been interested in contributing to Git
since 2024.

The sheer amount of people all across the globe actively using Git and/or
engaging with software that was produced also thanks to Git, makes this
FOSS project, to me, one of the most interesting ones in the world.

Being responsible for the maintenance and development of a software with
this amount of users is extremely challenging, but also really rewarding.
Furthermore, the developers in this community are some of the best in the
industry, and working with them is an amazing opportunity that cannot be
missed.

Finally, simply put, joining the broader Linux community is a dream of
mine, particularly to work on Git and the Linux kernel. In fact, during
February 2026, I didn't work as much on Git, because I was focused on
applying for the LFX "Linux kernel Spring 2026" mentorship to fix bugs in
the Linux kernel.

## Why me?

I hope that it's evident the amount of time and effort that I have put
into this proposal. I intend to give my absolute best to make this
project a success.

Also, having already participated last year in the Google Summer of Code,
I am already very familiar with this online program: I know the dos and
don'ts, and will apply what I learned last year during this term.

Finally, I also intend to continue contributing to Git, particularly to
continue to expand and improve the partial clone feature, which I find
particularly fascinating.

------------------------------

# Links

[1]: https://github.com/LorenzoPegorari/SimplyColorful
[2]: https://summerofcode.withgoogle.com/archive/2025/projects/25f08iuM
[3]: https://lorenzopegorari.github.io/GSoC25-report/
[4]: https://lorenzopegorari.github.io/GSoC25-report/logs
[5]: https://lore.kernel.org/git/20260216132317.15894-1-christian.couder@gmail.com/
[6]: https://git.github.io/General-Application-Information/


==============================


Thanks,

Lorenzo
