From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v6 00/32] refs backend
Date: Thu, 25 Feb 2016 19:57:32 +0700
Message-ID: <CACsJy8DEtmYnmwENws0Hb_2Do_sQkKEaraz=vxgrCyTOV-3FVg@mail.gmail.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 13:58:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYvUh-0000mD-7P
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 13:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759756AbcBYM6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 07:58:06 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:33282 "EHLO
	mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759381AbcBYM6E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 07:58:04 -0500
Received: by mail-lf0-f53.google.com with SMTP id m1so32597380lfg.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 04:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gGT26kKcNtYhszqHf0/dPDgdMZnjPS6knOwMvP0rlOQ=;
        b=etvIcO86szMwYhTZdP0ujyi+KPQIk5ahRN9s7KjsZTjnSm7fYMDocQ9gGnMIZW/huc
         h718nI98Xg0/Nc3f29LACGiwzfMAX5P76u7D7dRCPTpW2UmAy7oTcCp1cZv++mdQjcTS
         dw9PXzncXcbCCjTuQ3zhXMvBLHryZUVf8KEg5hRHKqORbXHLtkbZVZnBuyHQ4ffQQasa
         XDsPKpA4D32D3cttfIAPYeMB3EQlu0Op+gViQXCN0NdRrMmkNhlnxF+9oEE8y+E5Qxf3
         jOzNrwqV4OhxTphknhZpkBk9wWlFZ3GyoWAckChvwU8Z/10qlDZGokVpRZMmyJR7td93
         bf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=gGT26kKcNtYhszqHf0/dPDgdMZnjPS6knOwMvP0rlOQ=;
        b=dOSMRLyQ52oxHiCUO7KRfLcPiHw+ZcmL7ZgBImKZhRxoEzpTkVwY/K/neDuEWOC8Hz
         8Uz1c84lijdD5FE2Bw3n4i/uBgpjAR70MslTBjxrzhiRharFB+2iyjp1O+rvWoVzpm8+
         Qfkj6eEmrWV9jDxWdjf5KDKlSZv1Y4Q9dvguZX/7TKcu9tp6Fn66yCFW42/uHIMedeW4
         SF6sFgg3PwABdmdMc+X7YfLFShWcrwAjlaPA2/BLBzVERslC0fgf7gKEGCycfPfquZ3O
         ++0P8G87DGxw8W+cGN48e4iekepEIDkDIW2QH5QDWjDx9g7W+DznQM4yv8JgR4PCpw+U
         Dkdg==
X-Gm-Message-State: AG10YOT2xixKKU8JEcV2DSkmDbyCdDAePxnmaaeXZ3iOvsWmf/wtueAt2mdtLGhPlxFM7QuyeWzk6HuveqOE+g==
X-Received: by 10.25.4.7 with SMTP id 7mr16271726lfe.45.1456405082263; Thu, 25
 Feb 2016 04:58:02 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 25 Feb 2016 04:57:32 -0800 (PST)
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287365>

A couple of build warnings I found, haven't really read the code yet.
These two can easily be fixed

refs/lmdb-backend.c: In function 'lmdb_read_raw_ref':
refs/lmdb-backend.c:554:16: warning: unused variable 'err' [-Wunused-variable]
  struct strbuf err = STRBUF_INIT;
                ^
refs/lmdb-backend.c: In function 'lmdb_do_for_each_ref':
refs/lmdb-backend.c:1625:15: warning: unused variable 'c' [-Wunused-variable]
   const char *c = resolve_ref_unsafe_submodule(submodule, refname, 0, oid.hash,
               ^

-Wshadow also gives a bunch of warnings, mostly about "transaction"
and "env". Whether you want to fix them is really up to you.
--
Duy
