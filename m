From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 07/16] prepare_tempfile_object(): new function, extracted from create_tempfile()
Date: Tue, 11 Aug 2015 12:38:29 -0700
Message-ID: <xmqqh9o5r4y2.fsf@gitster.dls.corp.google.com>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
	<29cc87f510f6bc171c3ed76767b68f67ef403223.1439198011.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Aug 11 21:38:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPFNc-0006QY-9z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 21:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbbHKTic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 15:38:32 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33424 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334AbbHKTib (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 15:38:31 -0400
Received: by pabyb7 with SMTP id yb7so136536351pab.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 12:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GBuy4WpRoJn4+6velhojPaNVn565zlIRkkVxHSwNT44=;
        b=vH9LncAzDI88FHtW76heBZwfJD2bc7qLN4+Qa3/j0mYz9veHySo3z0NK/4ciSsvdHV
         leutMr4hTScBF7CfusXotyZHSZmEE56IKVWNyf+PN1/VD29w9v+r7ZYgxjGvWhc0QA0G
         p8kb57XtUB/BwnxNlAyWjUQZAmtZvcsgPYlfnX7TYlEOa2qdTBqzpewB9WLY9noF+Tsr
         Rbwj+DxOmE/z7rIY5CoHcvNJehXR2hXm+AoJmjpOS7I4s1epz3HIpwaZ98vvhQngkfIA
         MMT0ENcXuwAyNbjLs7sWz9tYZlsOY5DQWS06/ssn2B+82y4nwYa7qE5NhvJRzHoGIfmA
         9tgg==
X-Received: by 10.68.218.136 with SMTP id pg8mr59673835pbc.169.1439321911109;
        Tue, 11 Aug 2015 12:38:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id u10sm3641918pbs.16.2015.08.11.12.38.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 12:38:30 -0700 (PDT)
In-Reply-To: <29cc87f510f6bc171c3ed76767b68f67ef403223.1439198011.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Mon, 10 Aug 2015 11:47:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275715>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This makes the next step easier.
>
> The old code used to use "path" to set the initial length of
> tempfile->filename. This was not helpful because path was usually
> relative whereas the value stored to filename will be absolute. So
> just initialize the length to 0.

Makes sense.
