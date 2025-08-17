Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8B1448E0
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 20:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755461881; cv=none; b=Vpj5ysljibzl0dmeS0G0hJH1xjqO1E/SzV1NR3Tpoqii5qnLJcfQQMuvqflSTklzNVUmoHvz7diiZBd/LRzWyC/NZok2kuTBeKGNroN4kuTHezeAlQjk8lPDS2EKCYHlN2eHiTJ0Yvi0jOq3xt2vmKXBPwMmt/u41QtqHHJOC00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755461881; c=relaxed/simple;
	bh=elyYAy23ejuX1CUfXSEkRRaCNAZeOpGku/Z6875Qq4E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=qg63nvLl5N+dLC4XPZPPfDMn7dj4C2LZvABvDcw9lfytUGImrJS6AgBy4Lfa4eN3OftPG8/MfzOQyWR1h9NCTGXVVH1ccDnuorEKnvUjAjcUjtC7t2ptnbFbEbZjRv4LCSCCY2oPE3/eWF4O2Lxl72S0iF7zi5oZ7jJGUPEhy7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnI27TYy; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnI27TYy"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-333f92b4072so26201331fa.3
        for <git@vger.kernel.org>; Sun, 17 Aug 2025 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755461877; x=1756066677; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cXXBtiHOavyOR1G05oscZHmkrm2xaVd0JotVuDJGDx8=;
        b=SnI27TYya6wHa4lTjGllVPSCNMFfhNZ1uorXlo/frT4qyDjFuBWTXcZdIKD58m+xqZ
         tdNpXEggG5gBCL996VD3HvLKZcGSPIl8gsc6MwvnNElzQpm1lDgv9eW35I1KgHCtbJN5
         tb95UVvBvaaRluk0qtZQ3X+j65yJhzfjVFcNm+pD+BRm2brHy/S4HuHTDzllc632GWyR
         lHJUJltsTs2Qgij8PyTU5afu2v1Klw2j3dacfmuSZnroIyXwv9MxOvbl65bSOs1I0x31
         JhfI+dM2qn7oN3hXfkaQgfgg0ytT3RiiVYyeYzPW9tNT85A+aXhh9BBPf9aKWfKbRtVm
         RBDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755461878; x=1756066678;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXXBtiHOavyOR1G05oscZHmkrm2xaVd0JotVuDJGDx8=;
        b=nQ5I2npAW9L1gUxqqU9qvJ/0+0awsrY0vBkUusoETSoR3Sn9VEhGF657TdKsizkU6j
         3Ip0bhox3Dmv1zKOVodetMxK5ycmCIgpjh/86gAg3w9yI/zxLeHtUYYjN+kQ0MiC/mIS
         B3Ed3Vm1EI0yOuIKqtbqgza4YBS+kQhLepSlKwZH8nstNIUh1CkewquFRqW1lM8ORWPn
         CKo9wzqG7zA4yoqE+S1FZXCKMIwlFCgDWN9n6hfB6ln6PUjvbVT+783loHkI0/PVJkKJ
         T+pwWK/FDedYkvMfMIuuiaDJ5qOEt1oL1anHeFwLqbCJ95X24e71J73nvijqhCZujXyc
         X3Xw==
X-Gm-Message-State: AOJu0Yy8ic/3eVQEszc7REpWyIncC/TV76kWnDiBzWjl+dQXwlo/M+TT
	OlQaVfI3BE/Bc3bT55hTiSpwekGF3fO4V2mw9B5x/FsXwDkEk9FVbf/fi2d+Z0pim+4mWZW+HPV
	fRN0aDVhBvuGw2OGizOzCAXuOpN69WlYAVhdo
X-Gm-Gg: ASbGncuXX0AjgFL/BKj5lXDedAIbFnl1Wv+SGatqygS3tT6DVctvqEIUHGo3IcduX9K
	y23Ogc8JRyV+xizqVdMukI0wKdLJhJrjNNVpATSu7HtKChMt/foCcLckuKM/rVDj4PniVHo+Kfj
	6ln2/qsklmkl0NWq+l+FfMByisQ/qcwZTIGzW4YQGKUvttiUVvBHNPdVNPJSdMsD9cpVyvdk+1v
	PxHHDYxpvG9AcHbzmJTLw3E4IzRKZ6MUGvbQy12HRfZR3So+fM=
X-Google-Smtp-Source: AGHT+IGgd+4mYFSQZaDVYwVSNufUwbZME4LcFW8D7mMt4AEHWhs6ZXtDW8sKs4gKSXeXjjsoqX9IO+naLE1WzkyzJkk=
X-Received: by 2002:a05:651c:699:b0:334:905:e438 with SMTP id
 38308e7fff4ca-334099fe976mr17921631fa.40.1755461877257; Sun, 17 Aug 2025
 13:17:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ron Ziroby Romero <ziroby@gmail.com>
Date: Sun, 17 Aug 2025 21:17:46 +0100
X-Gm-Features: Ac12FXwEUtgSn2L6huDk5LYaeY7OWTRDcPJcHNqmSrCznjVdqFo8l9ENAp-8Wq4
Message-ID: <CAGW8g7mV6az3ybYf3uzHYQTGLDwc34eebZnha1EQ3Sb6B8E-fQ@mail.gmail.com>
Subject: [RFE] Add JSON output to git log commands
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would like to add JSON output to the git log command.

## Motivation

Machine parsing of git log output is prevalent, but git only provides
human-readable output. Having git output JSON directly solves problems
with the format option or third-party tools. Git has the information
in a machine-readable format. It should output in a machine-readable
format. JSON is ubiquitous and easy to generate, and therefore, it
makes sense to output JSON.

The author of one of the third-party tools says that JSON output is
the natural evolution of the Unix philosophy and should be done
natively for all tools[4].

## Current behaviour

Git log can output human-readable output in several ways. However,
outputting in JSON requires third-party tools or hacking pretty
output.

## Proposed enhancement

Add a =E2=80=93pretty=3Djson flag to output logs in JSON format.

## Alternatives

### Why natively?

The `jc` command parses git log output to convert to JSON[3]. However,
it post processes and has some difficulty with time zones in dates.
Also, the author considers it to be a stopgap until Unix tools can be
adopted to output JSON natively[4], which is what I'm proposing.

In a TIL post[2], Simon Willison showcases a method using pretty
output with nulls piped to jq. This method uses the pretty command to
get delimited output. However, this script doesn't handle all the
output from git log.

Tools like git-log2json[1] parse git output post-hoc, rather than
producing structured output from git.

Providing git log in JSON format will allow us to go to the source,
where we have the log output in machine readable form, and output
directly in machine readable form directly, without going through an
intermediate format

### Why JSON?

JSON is a sufficient and popular output format. It is sufficient in
that it can represent all the fields of git log in a way that allows
for special characters like quotes, newlines, and control characters.
It is also popular. Every language has libraries to parse JSON,
including the command-line utility jq, which can read and mutate JSON.

## Use cases

The JSON can be used by tools or piped into jq to extract and
manipulate the data. Scripts can be written to work with the JSON
output.

## Design outline

* Add a `PRETTY_JSON` constant.
* Create a pretty-json.c file to output JSON log information
* Modify pretty.c to call pretty-json to output JSON when the flag is set.
* Use existing utility functions written in the existing source to
output the JSON.

## Example output

Here=E2=80=99s a sample with two commits:

```JSON
{
  "commits": [
    {
      "commit": "3857aae53f3633b7de63ad640737c657387ae0c6",
      "refs": [
        "HEAD",
        "refs/remotes/origin/main",
        "refs/remotes/origin/HEAD"
      ],
      "author": {
        "name": "Somebody J. Example",
        "email": "somebody@example.com",
        "date": "2024-09-25T18:23:49-07:00",
        "timestamp": "1727313829"
      },
      "committer": {
        "name": "Somebody Else",
        "email": "somebody.else@example.org",
        "date": "2024-09-25T18:24:52-07:00",
        "timestamp": "1727313892"
      },
      "message": "Do a thing\n"
    },
    {
      "commit": "1522467d13a8fe29eb32209f175722df41e224b6",
      "merge": [
        "f92c61aef0190641e01294dad3b891b28113e1d5",
        "7ffcbafbf32185da7dccb4b3f49b871f24ab58c4"
      ],
      "author": {
        "name": "Somebody J. Example",
        "email": "somebody@example.com",
        "date": "2024-09-25T18:24:52-07:00",
        "timestamp": "1727313892"
      },
      "committer": {
        "name": "Somebody Else",
        "email": "somebody.else@example.org",
        "date": "2024-09-25T18:24:52-07:00",
        "timestamp": "1727313892"
      },
      "message": "Merge something\n\n* This,\n* That, and\n* The other\n"
    }
  ]
}
```

## References

> [1] Context-Driven Testing Toolkit, git-log2json: Convert git log to JSON=
, GitHub repository, https://github.com/context-driven-testing-toolkit/git-=
log2json

> [2] Simon Willison, =E2=80=9CConvert git log output to JSON using jq,=E2=
=80=9D til.simonwillison.net, March=E2=80=AF22=E2=80=AF2023. https://til.si=
monwillison.net/jq/git-log-json

> [3] Kelly Brazil, jc.parsers.git_log: JSON parser for git log, jc documen=
tation, version 1.5. Retrieved via GitHub Pages, https://kellyjonbrazil.git=
hub.io/jc/docs/parsers/git_log.html

> [4] Kelly Brazil, Bringing the Unix Philosophy to the 21st Century, Brazi=
l=E2=80=99s Blog, November=E2=80=AF26=E2=80=AF2019. https://blog.kellybrazi=
l.com/2019/11/26/bringing-the-unix-philosophy-to-the-21st-century/
