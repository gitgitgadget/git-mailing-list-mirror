From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 00/12] Allow reference values to be checked in a transaction
Date: Thu, 12 Feb 2015 12:12:11 +0100
Message-ID: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 12:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLrhR-00045M-U1
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 12:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755602AbbBLLMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 06:12:41 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:53847 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755596AbbBLLMi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 06:12:38 -0500
X-AuditID: 1207440d-f79976d000005643-49-54dc8a9f880c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id B2.B7.22083.F9A8CD45; Thu, 12 Feb 2015 06:12:31 -0500 (EST)
Received: from michael.fritz.box (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CBCT7T003107
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 06:12:30 -0500
X-Mailer: git-send-email 2.1.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsUixO6iqDu/606IwaZZOhZdV7qZLBp6rzBb
	vL25hNHi9or5zBbdU94yWvT2fWK12Ly5ncWB3ePv+w9MHjtn3WX3WLCp1OPiJWWPz5vkAlij
	uG2SEkvKgjPT8/TtErgzTrz5ylrQLVix+X1ZA2M7bxcjJ4eEgIlE0+rvLBC2mMSFe+vZuhi5
	OIQELjNKzOxayAySEBI4wSSx4g4riM0moCuxqKeZCcQWEVCTmNh2CKyZWWA1k8TWu0DNHBzC
	Av4S/QfLQEwWAVWJy6ukQCp4BZwldi3YxQSxSk7i/PGfzBMYuRcwMqxilEvMKc3VzU3MzClO
	TdYtTk7My0st0jXSy80s0UtNKd3ECAkX3h2M/9fJHGIU4GBU4uENML4TIsSaWFZcmXuIUZKD
	SUmUl6sVKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE17cJKMebklhZlVqUD5OS5mBREudVW6Lu
	JySQnliSmp2aWpBaBJOV4eBQkuCV6gRqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3J
	iAeFeHwxMMhBUjxAe8VA2nmLCxJzgaIQracYFaXEeQ1AEgIgiYzSPLixsCTwilEc6Eth3nkg
	VTzABALX/QpoMBPQ4IkzboMMLklESEk1MNo+E5uWbnXvSMR/u0WBL1yWvD9nUxdqpXiG/Yv+
	02uTRR+JWl/5fgtowzMv5QjpW7FWm789XSrv4ua4UpXlSvV/37tXdy/YdMhy29En90LM5aVk
	rC9235/Nf9P26Pcru5xrz70qvDF3SlndFvl49tXbHJe3HbmwWVZ4iSBTRpV+Btch 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263718>

This is v2 of the patch series, with only minor changes from v1 [1].
Thanks to Stefan Beller and Junio for their feedback about v1. I think
I have addressed all of the points that were raised.

Changes since v1:

* Rebased onto new upstream master (because it now includes the
  dependencies, mh/reflog-expire and sb/atomic-push). The rebase was
  conflict-free.

* Tweaked some commit messages and added some Reviewed-by lines.

* Patch 06/11: Remove copyright line from t7516. Use write_script
  function to write the fake editor.

* Patch 12/11: New commit: consolidate comments for the four reference
  transaction update functions.

This branch is also available in my GitHub account [2] as branch
"refs-have-new".

Michael

[1] http://thread.gmane.org/gmane.comp.version-control.git/263522
[2] https://github.com/mhagger/git

Michael Haggerty (12):
  refs: move REF_DELETING to refs.c
  refs: remove the gap in the REF_* constant values
  struct ref_update: move "have_old" into "flags"
  ref_transaction_update(): remove "have_old" parameter
  ref_transaction_delete(): remove "have_old" parameter
  commit: add tests of commit races
  commit: avoid race when creating orphan commits
  ref_transaction_create(): check that new_sha1 is valid
  ref_transaction_delete(): check that old_sha1 is not null_sha1
  ref_transaction_verify(): new function to check a reference's value
  update_ref(): improve documentation
  refs.h: Remove duplication in function docstrings

 branch.c                |   5 +-
 builtin/commit.c        |   4 +-
 builtin/fetch.c         |   6 ++-
 builtin/receive-pack.c  |   5 +-
 builtin/replace.c       |   2 +-
 builtin/tag.c           |   2 +-
 builtin/update-ref.c    |  17 +++----
 fast-import.c           |   6 +--
 refs.c                  | 130 +++++++++++++++++++++++++++++++++---------------
 refs.h                  | 111 ++++++++++++++++++++++++++++-------------
 sequencer.c             |   2 +-
 t/t7516-commit-races.sh |  33 ++++++++++++
 walker.c                |   2 +-
 13 files changed, 227 insertions(+), 98 deletions(-)
 create mode 100755 t/t7516-commit-races.sh

-- 
2.1.4
