From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 00/22] backend-struct-db
Date: Fri,  8 Aug 2014 09:44:47 -0700
Message-ID: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIJ-0007Q7-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756785AbaHHQpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:20 -0400
Received: from mail-qg0-f74.google.com ([209.85.192.74]:43565 "EHLO
	mail-qg0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756107AbaHHQpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:16 -0400
Received: by mail-qg0-f74.google.com with SMTP id z60so766056qgd.5
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=W7+Q/t2w/qFBpMFsaE8vMmkbU+94RVJWlWZFwEKZSHU=;
        b=Yph2eUVj2WKAW9gCmtLj4yojStZyrdj3Dlfy/o1gRHVeC+JaKw0/JZCGUHlnZnWHPp
         CCME1bwoROonEY55RvBSxO56qb0ndTS2l9h8EDr9PHNE9RLHwxx/nPm/u0SFX4B7NRU4
         jnu1Oerjnw4TYYnZJQKkt5HVkmod+nbUE3PND3fMh5idjO6L3CAUNf2TQN7aMCF14lZy
         Hxpocm7cUE4L2X2UStdpvN3I97ZMWzCGylIFMjcSEdGmfcM/m2+j7Bp7pJYrDFzyNQim
         dG++jZVenwi6Cc18BvOSk3aBavFhQrXMNb6MhEwgwt5vWNC5YBMkEuIFg4B8kAH4ZU8P
         TBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W7+Q/t2w/qFBpMFsaE8vMmkbU+94RVJWlWZFwEKZSHU=;
        b=l1ickwAPM2/GVb+t8d4YutF/MViD1AEp0wbU3hBQ3LyKpA4brKzLE67HO5jEZipPxI
         YrKjyaqa+qiz1a4ADNSvlpEdu2AFYb5C/dXW4ZPutxU6lgxZJV6Ghfqkm1c52xL6nh7S
         nu4xUmbrKeg0uh07A2Wg8+erLvKSnN/HQvtl62HfwCOp2EL2v35lekCn85lcZsM86nYe
         J0T2QOUVbh8x01/pF6ySTEw/IKzPrvetqZWtJxhtroCD1GZWlnsBfPewh5n6rfIXuk3+
         5NCfqc8/TRwIStJXXG8FGn3pYiWdxZD/9wusCYx+Ol/7g1fjd6vJlmEk/1owiJFQsCSn
         2AzQ==
X-Gm-Message-State: ALoCoQmTntriuBWe22dDiSs6f8rxROOP5pfHOleXercTMdaPah9Fh6cAVvBO7GW1ZS5AiNSi4MMs
X-Received: by 10.236.111.106 with SMTP id v70mr5216721yhg.21.1407516315319;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id l23si505694yhg.1.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 2527431C40F;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id BA770E0C50; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255027>

List,

This series is called backend-struct-db and is also available at
https://github.com/rsahlberg/git/tree/backend-struct-db

This series is built on and follows after the series
ref-transactions-send-pack


This series does not change any logic or behaviour but mainly just shuffles
code around and adds method pointers for the backend functions.

The first patch adds a new public function for checking if a refname is
available or not. This function is needed not because we want to have
different is_refname_available semantics for different backends, we don't,
but because its implementation is quite dependant on the backend type.

15 of the patches, the refs-common.c patches, focuses on moving all backend
agnostic refs functions to a common file. This file will contain all
backend agnostic refs functions.

The last 6 patches adds a backend structure with the methods we need to
describe a pluggable backend. Currently we only have one built in backend,
the current files based backend. These patches do not change any of the
behavior other than that we now call the methods through backend specific
wrapper functions rather than calling them directly.


At this stage we now have a defined set of methods needed for a refs
backend and we can start building and adding new types of ref backends
to git.




Ronnie Sahlberg (22):
  refs.c: create a public function for is_refname_available
  refs-common.c: create a file to host all common refs code
  refs-common.c: move update_ref to refs-common.c
  refs-common.c: move delete_ref to the common code
  refs-common.c: move rename_ref to the common code
  refs-common.c: move read_ref_at to the refs common file
  refs-common.c: move the hidden refs functions to the common code
  refs-common.c: move dwim and friend functions to refs common
  refs-common.c: move warn_if_dangling_symref* to refs-common
  refs-common.c: move read_ref, read_ref_full and ref_exists to common
  refs-common.c: move resolve_refdup to common
  refs-common.c: move check_refname_component to the common code
  refs-common.c: move is_branch to the common code
  refs-common.c: move names_conflict to the common code
  refs-common.c: move prettify_refname to the common code
  refs-common.c: move ref iterators to the common code
  refs.c: add a backend method structure with transaction functions
  refs.c: add reflog backend methods
  refs.c: add methods for misc ref operations
  refs.c: add methods for head_ref*
  refs.c: add methods for the ref iterators
  refs-be-files.c: rename refs.c to refs-be-files.c

 Makefile        |    3 +-
 refs-be-files.c | 3343 +++++++++++++++++++++++++++++++++++++++++++++
 refs-common.c   |  956 +++++++++++++
 refs.c          | 4082 -------------------------------------------------------
 refs.h          |  117 ++
 5 files changed, 4418 insertions(+), 4083 deletions(-)
 create mode 100644 refs-be-files.c
 create mode 100644 refs-common.c
 delete mode 100644 refs.c

-- 
2.0.1.553.geee1b3e
