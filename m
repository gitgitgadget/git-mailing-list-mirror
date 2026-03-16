Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3F32D45C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691145; cv=pass; b=OK4fIN1jvU6Rl8/wxtOKbDi9e/TwioDJ+S65cqTio0f4CdBP3pheCUXjILXbOlVw4HjxmqokYijyVAtv2KxQoL1SNPzGSrTmIBGb+amY4NK1ihdFhYOSrEPtWbCezOSsbDQ/vHv2w4/YCuuopyvD3SP3HpK5c0ncMK+Ng59Kqmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691145; c=relaxed/simple;
	bh=N9A5ss7UGDBWVTsWr7/kRTLcM/0h7U59eYw+G6HlCt8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A6BcENi9SdbF1LCjwjPC7AmY5amNlUUgSmvgq/FRWOY9VHD10pu1+4erFW986ikwmtL8SngL9YmYM2fD4gwRcLNW/vS6Ik9u1riSaPPXTOFE7r/1emKnWP6/1qzr5Ipiq9zjjX1CZlMhCjCRu4xS0frkOsKIxr5rj1gxT0scDtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eIBFvbhX; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIBFvbhX"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2c0c482e069so1148167eec.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 12:59:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773691142; cv=none;
        d=google.com; s=arc-20240605;
        b=JqIHJUcRhTKLFO8AvEB6WcXxc/tcTuEx9heqW+3I7n6OehZ+p+JxNCKs0rJIOLYOr/
         K5U1ReIPwfUGhykSKWuyV4CiongvLveK59f7o7v21ADa4dCTHFdsNRRBF1RThMH5xLO8
         /k38gJlgqYMq0ni5id5YR+sn6cdgZW9gIRIek8DEuj3pEQStXNikPCASXi/dvtNGQIsk
         UqTCO8HKeiPLFVwRM/ls+HIuLDIJRJeuhewAezKWlNQd8cEFU+Xp4d9gAWFXXHdekyd6
         OS2dqOjNf0nzEOJVpNFV6JSBduYhp7jfIO2MJQ8B4A+wv845gjIdbu5O3VURrDs1RpHh
         ybsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=zDoGgvcA1QVHcAJNUgc3OlTCvVSt1vk8Oe9LnR74XOY=;
        fh=iVssCG1e8yiRsCi7Gq3ZUe4/bHeGKNp+3Waj0XRMcOs=;
        b=Qh8KIeCmz/l21t8WHz+FpUcVi3c9lTntf6+jyA36msSCnOn9yBGF5LEeZ7nTGjbzJP
         DBA2KLgUdqnUFwYZumc2apKuZau6HIZXfD+DzwCTawpEJKopsoY8FCS4k3qKF+oOUOlg
         L32Tbeac7D2vFAnVbooMz4bGj7K2J0D3M7uBkAe3Pj32sQyjCPF9JN70YXnrTFXTZqZw
         VaLo1+mbn80AjVaU4iTZnsKJvQERx48Kz8hc/8/Yp7uZGhMmndEZJWmrFuceHZsj4ID+
         bD8q7LqfTAtIZzJjiNW5Z+L/rY8IS4UMt2iaj0aNWZw13iasoFCHvZ3NBegCTiUSXkM+
         qYKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773691142; x=1774295942; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zDoGgvcA1QVHcAJNUgc3OlTCvVSt1vk8Oe9LnR74XOY=;
        b=eIBFvbhXRe2/GteQLP1aYQ03QAK9ElAELLRaVCYlv4bM4ihHwmk58qu4dJp414wPfB
         h9XTK7VlOL/iQWFpuNSuqSz5ZPec07pHZmOXua53/hRoeCYPsW/3J15QvxknvgOZgSQ2
         4dSpFqOIt/9dbL6dTTyT3bMoaP2O4WMlb9yCJVlY9n0VI/CxUQvbQV/hattyIFHIbYMZ
         x4h8Soxyi1Cf7I9TVTCTGjpcwyCAhR4NgtizxsazgNMzQBQSnjNgxF1Phhv/IyG+0IMa
         4Tptijdd15lUaSqis4jvSlndXlqsTccgc6/DMebKcrB7lODhv+VucbpTtmRd9usKjY8m
         9XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773691142; x=1774295942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zDoGgvcA1QVHcAJNUgc3OlTCvVSt1vk8Oe9LnR74XOY=;
        b=Uf0sd2VUsP6KDyEYzt94bFyyahMYpyscxqnU1UECE7XEDKdbBG2Q6Dykd9SKQt5l3R
         MT0gHJxSYmtSu1fpoYXWp9dhIrMWBvA4IY7pQPDHABwKF85PKWwSbbtClbBY5MZeeBdO
         YTkmNEhWV8/OE0CaQPp0lhNcXv/+b2AzI517fkEPTOLdPaFb+iN51td2KGCeo1nJORIh
         mfnadKK07D8dv0ltwNvtohiqOIBtgJsJpBiAIq5PDgiL2xRBDG5ubYgKq+cXMLat7g1+
         Bmwj2PV1+t+JjgjtH4fC2E7fQqveViT0hMTfIv9AcRYNXF6Q0LN4AYXThKtq4qQePs9V
         rg6Q==
X-Gm-Message-State: AOJu0YzStzt6SRp3vZ+9lE+sendbWlD6wPZy3lhm1E+Hw3iJh86keTrG
	rK3+qWpUiJURN5yirFmqj3UrnycLVJbua+WZqxd+OuB2I3MNMwvkWsLo/Ao9EHsX47s9ei3n/n2
	xp6xD8IRP+tuA7w3oA562CXxT1CJ8F3lSm96Y
X-Gm-Gg: ATEYQzyjwx+DXBjmlvfCoAO4Qc4x42LI0RVcdMZblflFs3GPyCE6AViG6FHht6xJl3c
	cLYlpeB2l0urokJYlVCuX6TQvxFq+2XfqEZpNuX4UbDe8X5joc3yHU4RXfVAQNgrHPoitVPB1yz
	Q9LbRMUQgF8PBpQJ76geDVAU0igJQKEV5gjAYk+LLJlss4LJvznuDUJF2xtOqX1YudhXkN8SE5h
	L2koBMIx/850XymEwyyMtDRw2GKMLsUR3MoliLUlj11oiUFufkrkaknBa5Gdv2gyUpssFi7mnbY
	bjKMGEy6PSaDBp/b/QsdnvNNS8Lr4Hd+A30b3G8pNMWGPMamVxTiGeguALNN0Fw6Xiha/moCLQ=
	=
X-Received: by 2002:a05:693c:40c2:b0:2c0:bce6:61b2 with SMTP id
 5a478bee46e88-2c0bce663ecmr1760884eec.30.1773691141687; Mon, 16 Mar 2026
 12:59:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Tue, 17 Mar 2026 01:28:48 +0530
X-Gm-Features: AaiRm53BYMtzrdcRlr5qqTYH-j1tGvJCjJd0brHhWQxE9Va8xVZFiMSzcpsR58A
Message-ID: <CAG7UgEQTPhxPeEYkm44+BuSj5GG6PWhRrqGT7Vq7zXFPKZqoag@mail.gmail.com>
Subject: [GSOC][RFC] Draft Proposal: Complete and extend the
 remote-object-info command for git cat-file
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi! I would be grateful to get feedback on my proposal draft for GSoC
2026. Thank you very much!
-----------------------------------------------------------------------

Complete and extend the remote-object-info command for git cat-file

-----------------------------------------------------------------------

Personal Information

Name: Deveshi Dwivedi
Email: deveshigurgaon@gmail.com
GitHub: https://github.com/deveshidwivedi
Time Zone: UTC +5:30 (IST)
Education: Final year, IIIT Jabalpur
Blog: https://deveshidwivedi.github.io

-----------------------------------------------------------------------

Past experience with Open Source

I have been contributing to open source for the past few years. My
first contribution was during my second year of college. Since then I
have tried contributing to different projects to get better at
navigating unfamiliar codebases and understanding how real-world
projects are maintained. Some of my contributions include:

- https://github.com/processing/p5.js-web-editor/pull/3492

- https://github.com/neovim/neovim/pull/33235

- https://github.com/kube-vip/kube-vip/pull/1087

- https://github.com/WasmEdge/WasmEdge/pull/3963

- https://github.com/openfoodfacts/openfoodfacts-server/pull/10037

- https://github.com/openfoodfacts/openfoodfacts-server/pull/9967

- https://github.com/processing/p5.js/pull/6761

- https://github.com/processing/p5.js/pull/6669

I was also grateful to be an LFX mentee in Summer 2024 under the Open
Mainframe Project. During the program I worked on building a new
frontend for the Software Discovery Tool and integrating it with the
backend to make the tool easier to use.

-----------------------------------------------------------------------

My contributions so far

*t5403: use test_path_is_file instead of test -f
*Mailing list: https://lore.kernel.org/git/20251229185737.2328-1-deveshigur=
gaon@gmail.com/
*Status: merged in 'master'
*Description: Replace test -f with test_path_is_file helper in
post-checkout hook test for better failure diagnostics.

*t5403: improve post-checkout hook testing
*Mailing list: https://lore.kernel.org/git/20260112163643.231-1-deveshigurg=
aon@gmail.com/
*Status: merged in 'master'
*Description: Introduce check_post_checkout helper to eliminate
repetitive hook validation patterns, then switch to test_cmp for
clearer argument mismatch diagnostics.

*t1006: fix %(rest) test for object names with whitespace
*Mailing list: https://lore.kernel.org/git/20260219152407.12160-1-deveshigu=
rgaon@gmail.com/
*Status: dropped
*Description: Submitted a patch to address a FIXME in t1006 around
%(rest) behavior with whitespace in object names. Junio explained that
whitespace-as-delimiter is documented behavior for %(rest), not a bug,
and Victoria clarified the FIXME was intentionally documenting a known
limitation, not requesting a fix. This taught me to read test comments
in their full historical context rather than treating them as isolated
tasks. It also introduced me to t1006-cat-file.sh in depth, which is
directly relevant to this project.

*avoid unnecessary strbuf_split*() and strbuf-by-value usage
*Mailing list: https://lore.kernel.org/git/20260311173336.8395-1-deveshigur=
gaon@gmail.com/
*Status:Will merge to 'master'
*Description: Eliminate inefficient strbuf_split_str() in combine
filter parsing by using direct string traversal with strchrnul(), and
convert write_worktree_linking_files() to accept path strings instead
of strbuf-by-value parameters.

*coccinelle: detect and fix strbuf-by-value parameters
*Mailing list: https://lore.kernel.org/git/20260315094445.19849-1-deveshigu=
rgaon@gmail.com/
*Status: queued
*Description: Add Coccinelle semantic patch to automatically detect
functions taking struct strbuf by value, transforming them to pointer
parameters and fix the remaining instance in stash.c.

-----------------------------------------------------------------------

Project Overview

This project completes and extends the remote-object-info subcommand
for git cat-file --batch-command, which allows clients to request
object metadata from a remote without downloading full object
contents.

Goal 1: Rebase and finalize Eric Ju's v11 patch series [1], address
the remaining review feedback, and get it merged.
Goal 2: Add %(objecttype) support to the object-info protocol, end-to-end.

-----------------------------------------------------------------------

Proposed Solution

----------

Goal 1: Complete v11 Series

----------

Pre-GSoC Analysis:

I rebased Eric Ju's v11 series [1] onto the current master. There were
conflicts in t/t1006-cat-file.sh, fetch-pack.c, Makefile and
object-file.c. After resolving those and building, I ran the test
suite.

While running t/t1017-cat-file-remote-object-info.sh [2], the first
test failed with "ambiguous redirect". '$daemon_parent' expands to the
trash directory path which contains a space and the redirect is not
quoted:

echo_without_newline "$hello_content" > $daemon_parent/hello

The shell splits on the space and does not know which file to redirect
to. I grepped for other unquoted uses and found the same problem with
$HTTPD_DOCUMENT_ROOT_PATH/http_parent/hello in the http test section.
This is fixed once we quote both the instances.

In review of Calvin Wan's initial remote-object-info implementation
[3], Jonathan Tan observed that the remote-object-info state
is currently stored in static globals rather than in the shared
command data structure. This approach makes it difficult to support
mixing commands in a batch session. The v11 series addressed most of
this by restructuring the code so that remote-object-info now goes
through the same expand_data path used by info. However, one instance
of shared state mutation still remains.

In get_remote_info(), when no explicit format is given, currently the code =
does:

if (!opt->format)
    opt->format =3D "%(objectname) %(objectsize)";

The problem is that opt->format is shared across all commands in the
batch session. batch_objects() creates a single expand_data structure,
which every command uses. Mutating opt->format here permanently
replaces the original NULL value.

Fix: Instead of modifying the shared state,  we can use a local
variable in parse_cmd_remote_object_info():

const char *remote_format =3D opt->format
    ? opt->format
    : "%(objectname) %(objectsize)";

and pass remote_format to get_remote_info() for validation. This fix
is needed regardless of Goal 2. Even when the values happen to match,
mutating shared state from a command handler is incorrect. Once
%(objecttype) support is added, the special-case default disappears
entirely, and both local and remote commands can simply use
DEFAULT_FORMAT.

----------

Review Feedback Analysis

Below are the main issues raised during the v11 review of the
remote-object-info patch series and how I plan to address them:

Issue 1: Format Validation Segfault [4]
The current validation uses a strstr() check to ensure that the format
contains %(objectsize). This is not sufficient. A format like:

%(objecttype) %(objectsize)

passes the check but later causes a segfault.
The crash occurs in expand_atom():

strbuf_addstr(sb, type_name(data->type));

The call chain looks like this:

batch_objects_command()
  =E2=86=92 parse_cmd_remote_object_info()
    =E2=86=92 get_remote_info()           =E2=86=90 validation belongs here
      =E2=86=92 transport_fetch_refs()
    =E2=86=92 batch_object_write()
      =E2=86=92 expand_format()
        =E2=86=92 expand_atom()           =E2=86=90 segfault here

The problem is that data->type may never be initialized. When it
remains OBJ_NONE (0), type_name(0) returns NULL because
object_type_strings[0] is NULL. That NULL is then passed to
strbuf_addstr(), which dereferences it and segfaults.
Jeff King pointed this out during review [4]. While experimenting with
the feature, he tried:

git cat-file --batch-command=3D'%(objecttype) %(objectsize)'

and feeding it a remote-object-info request, which triggered the
crash. I was able to reproduce the same behavior locally using a
simple client/server setup and a blob from a test repository.

Fix: Instead of relying on a strstr() check, the validation should
determine which atoms were actually requested by the format. During
the mark-query phase, expand_format() records requested atoms by
populating the corresponding fields in data.info. After this stage we
can inspect those fields to see exactly which atoms were requested.

If the format asks for something remote-object-info cannot provide,
the command should exit with an error that names the unsupported atom.
The format is defined when the batch session starts, so requesting an
unsupported atom is a configuration error rather than a per-object
condition. Returning empty output would be misleading, since a caller
would not be able to tell whether the object actually lacks that
attribute or the protocol simply does not support it. Failing early
with a clear error avoids silently producing incorrect results.

Implementing this validation requires passing the expand_data instance
down to get_remote_info(). In v11 the function currently has the
signature:

static int get_remote_info(struct batch_options *opt, int argc, const
char **argv)

For this check to work, the expand_data pointer needs to be threaded
through from parse_cmd_remote_object_info(). This ends up being the
same signature change required for the format-mutation fix described
earlier, so both fixes can share the same small refactor.

As an additional safety measure, a defensive guard can be added in
expand_atom() so that it cannot segfault even if validation is
bypassed in a future code path.

Finally, the EXPAND_DATA_INIT macro currently initializes only .mode =3D
S_IFINVALID. It should also initialize .type =3D OBJ_BAD. Since OBJ_BAD
is -1, outside the bounds of the object_type_strings array,
type_name() will return NULL, which is then safely handled by the
guard above.

Issue 2: Misleading Input Overflow Error [5]

The current overflow check reports that the command contains too many
objects, but that may not be the real cause. For example, a very long
repository URL could exceed the line length limit and trigger the same
error. Junio pointed this out in his review [5].

Fix: We can handle this with two separate validation steps.

First,we can check the line length before parsing and report any
overflow accurately. After parsing, we can validate the number of
requested objects. Malformed quoting should also be caught during
parsing. Separating these checks ensures that error messages point to
the actual problem, rather than incorrectly blaming too many objects.

Issue 3: Code Style and State Management

The patch series also introduces a few style inconsistencies that
should be cleaned up:
- multi-line comment formatting
- missing blank lines between #define groups
- long macro definitions
- mixing size_t and int for loop counters

In addition, parse_cmd_remote_object_info() should reset all fields in
expand_data that it modifies before returning. The v11 implementation
already resets data->skip_object_info =3D 0 on both normal and error
paths, but it does not reset data->type or data->size. Resetting these
fields avoids leaking stale remote state into subsequent commands.

data->skip_object_info =3D 0; (already in v11)
data->type =3D OBJ_BAD;
data->size =3D 0;

Without these resets, a batch session that runs remote-object-info
followed by a local info command could produce incorrect output. If
odb_read_object_info_extended() fails for the local object, the
previously populated remote values may still be present in data,
causing stale data to be printed. It is also important that the
data->skip_object_info =3D 0 reset happens even on the goto cleanup
error path so that the state is fully restored before returning.

New tests to be added for v12:
- %(objecttype) %(objectsize) format: command dies cleanly instead of
segfaulting
- %(objecttype) alone: command dies with a clear error
- %(objectname) only: works without requesting size
- Mixed remote-object-info and info commands in batch mode: both use
the correct default formats (this also catches the format-mutation
issue)

----------
Goal 2: Add support for %(objecttype)
----------
Server Side

struct requested_info in protocol-caps.c is extended to include
unsigned type : 1, alongside the existing unsigned size : 1. The
capability parser in cap_object_info() is updated to recognize type
requests using the same pattern that is already used for size. The
server-side response logic in send_info() is then updated to include
the type when it has been requested.

One useful optimization here is that odb_read_object_info() already
provides the object type as its return value, while the object size is
returned through an output parameter. The current implementation in
send_info() calls this function but discards the return value after
checking whether it is negative. When both size and type are
requested, we can obtain both pieces of information from a single
call. If only type is requested, the call simply passes NULL for the
sizep parameter.

For loose objects, both the type and size are stored in the same
object header ("<type> <size>\0"). For packed objects, the type is
already in the pack entry header, so retrieving it is free.

When sending responses, send_info() includes both size and type in the
headers if requested. Each object line looks like:

<oid> <size> <type>

If the server cannot resolve an attribute, that field is left blank.
Behavior for missing values remains consistent with existing handling.

On the server side, object_info_advertise() in serve.c no longer marks
its struct strbuf *value as UNUSED and now populates it with "size
type". This means the server advertises:

object-info=3Dsize type

during capability negotiation. Older clients ignore the value string
per protocol v2 rules, and the server_supports_v2("object-info") check
continues to work, so backward compatibility is maintained.

----------

Client Transport

Before requesting type, the client checks whether the server supports
it using server_supports_feature("object-info", "type", 0). This looks
at the capability value and parses it with parse_feature_request(). If
the server advertises only object-info=3Dsize, the check returns false
for type. In that case, if the format requires %(objecttype), the
client exits with a clear error. When building the request,
unsorted_string_list_has_string() is used instead of strstr() to avoid
substring matches.

On the response side, the client keeps track of column positions using
size_index and type_index, both initialized to -1. The attribute
headers sent by the server determine which columns appear and in what
order. The data lines are then parsed using those indices with bounds
checks. Since column 0 is always the OID, the indices use a +1 offset.
For example: in <oid> 1234 blob, column 1 contains the size and column
2 contains the type. If fewer columns are returned than expected, the
bounds checks prevent out-of-range access.

----------

Memory: I will allocate typep per OID the same way v11 already does
for sizep; free_object_info_contents() handles cleanup.

----------

cat-file integration

In get_remote_info(), the format string determines which attributes
are requested from the server. Previously, if %(objectsize) appeared
in the format, "size" was added to object_info_options. With this
change, %(objecttype) similarly adds "type".

Since %(objecttype) is now supported, the earlier allow-list
validation that rejected data->info.typep is removed.

Supporting %(objecttype) also allows the removal of the special-case
default format in get_remote_info(). Both local and remote commands
can now use DEFAULT_FORMAT (%(objectname) %(objecttype)
%(objectsize)), eliminating the previous mismatch in default output.

----------

Backward Compatibility:

A new client with a new server supports both size and type. With a new
client and an old server, server_supports_feature() returns false for
type, and the client exits with a clear error if the format requests
%(objecttype). Size-only requests still work. Old clients work with
any server. They ignore the new type capability and only request the
attributes they understand, so existing workflows continue to work as
before.

----------

Testing for Goal 2

Server-side (t/t5701-git-serve.sh):

Server advertises object-info=3Dsize type
Correct type strings for all four object types
Combined size + type and type-only requests

Client-side (t/t1017-cat-file-remote-object-info.sh):

%(objecttype) across git://, file://, http://
Default format includes type after unification
Server that only supports size: clean error for %(objecttype)
Mixed local + remote in buffer mode (state isolation)

----------

Stretch Goals (if time permits)

If Goal 1 and Goal 2 land ahead of schedule, %(objectsize:disk) could
be explored. The server infrastructure already exists via
odb_read_object_info_extended() and the implementation pattern is
identical to %(objecttype). %(deltabase) is a similar extension. Both
depend on server pack format rather than intrinsic object properties,
so either would need mailing list consensus before proceeding.

-----------------------------------------------------------------------

Project Timeline

I have intentionally allocated slightly longer phase intervals to
provide a buffer. In practice, each task may take less time, but this
ensures there is room to handle unexpected delays without affecting
the overall schedule.

Pre-GSoC (Until May 1):
- Continue exploring the codebase.
- Stay engaged with the community and follow discussions.

Community Bonding (May 1 - 25):
- Study the codebase and internals in more depth.
- Review all v11 feedback threads.
- Identify rebase conflicts.
- Discuss protocol design with mentors on the mailing list.

Phase 1: Rebase and Fix (May 26 - Jun 15):
- Rebase v11 onto master.
- Fix all bugs: format validation, input validation, format mutation,
state cleanup, code style, test quoting.
- Add new tests.
- Send v12 to the mailing list.

Phase 2 (Jun 16 - Jul 6):
- Iterate on v12 review feedback.
- Begin server-side type implementation.
- Add server tests, send server patches.

Midterm (Jul 10):
- Goal 1 in final review or merged.
- Server patches posted.

Phase 3: Client and Integration (Jul 14 - Aug 10):
- Iterate on server patches.
- Implement client transport and cat-file integration.

Phase 4: Final (Aug 11 - 24):
- Final review iteration.
- Buffer for unexpected issues.
- Ensure all patches are in the review pipeline.

Final Evaluation (Aug 25 - 31):
- Address any remaining review feedback.

-----------------------------------------------------------------------

Availability

The project size is 350 hours (medium). I plan to dedicate around 35
hours per week during the 12-week coding period to work on the
project. I do not anticipate any major conflicts during this time and
will be able to stay actively engaged with development and
discussions.

-----------------------------------------------------------------------

Post GSoC

I would like to stay active in the Git community even after GSoC.
There is still a lot for me to learn from the project and the
community, and I hope to continue contributing and improving my
understanding of Git=E2=80=99s internals.

-----------------------------------------------------------------------

References

[1] https://lore.kernel.org/git/20250221190451.12536-1-eric.peijian@gmail.c=
om/

[2] https://lore.kernel.org/git/20240628190503.67389-7-eric.peijian@gmail.c=
om/

[3] https://lore.kernel.org/git/20220504212738.162853-1-jonathantanmy@googl=
e.com/

[4] https://lore.kernel.org/git/20240628190503.67389-1-eric.peijian@gmail.c=
om/t/#md20501dc269cc38ac1ac8cf7599281b937b651a0

[5] https://lore.kernel.org/git/20240628190503.67389-1-eric.peijian@gmail.c=
om/t/#mbe53f476d6cd32633277c28f17f8b6a59316b1db

--
Thank you,
Deveshi
