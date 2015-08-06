From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Error when cloning with weird local directory
Date: Thu, 06 Aug 2015 00:44:09 -0700
Message-ID: <xmqqtwsczws6.fsf@gitster.dls.corp.google.com>
References: <CAFOYHZByteuPZwRvw9tzFWOD6vguw4wPK1J6rLZZvHzyZRBtSA@mail.gmail.com>
	<55C2F54A.7070702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Chris Packham <judge.packham@gmail.com>, GIT <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 06 09:44:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNFqc-0006jb-DP
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 09:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754195AbbHFHoO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Aug 2015 03:44:14 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35601 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbbHFHoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 03:44:12 -0400
Received: by pabxd6 with SMTP id xd6so38702916pab.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=njsyCYO0URZfkj1m/2XR3gtgtTTQXZX8yHcJTHBL0fY=;
        b=Z4jcwNZX9XL8UVAcM9oFGwC/KJGSnl0ZSbQkdoEmn1f24BQVXTBT1q6KQsk0VjLnab
         6kiHsDoFY3HLC70o5e2KX6E+CqNjKvf5xg0MIj2qR35aYoE8Ks7PO8Uz7/7nEyVcQwn0
         K8RfyKsATgPl8ptaumHaJS8Ns70ZNDO0exBzsVn9OMVeWDeIRr5JvM2J5Ci9xFgrRVin
         6iUBVpBih54gt3j7+b7DrGs1+gXXNt66HL74yyVgRNIUNNZ/EmXP+BcTUWBGk1bzcqJy
         Bex0EeENrk8VlEn3QUH5H0AoPoC/FVCl9DuCaMfXuLGXkQRInTKL9n33H9D+fbzmb6R9
         k7Ag==
X-Received: by 10.69.3.228 with SMTP id bz4mr599028pbd.79.1438847052355;
        Thu, 06 Aug 2015 00:44:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:5cf0:2451:9503:37d])
        by smtp.gmail.com with ESMTPSA id x12sm5396593pbt.56.2015.08.06.00.44.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 06 Aug 2015 00:44:10 -0700 (PDT)
In-Reply-To: <55C2F54A.7070702@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 6 Aug 2015 07:48:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275418>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> It looks as if
> static char *get_repo_path(const char *repo, int *is_bundle)
> in built/clone.c
> checks if there is a local directory structure looking like a
> .git directory.
> This is wrong.

It is as designed, though, to allow cloning from a local directory
with any name.

> There should be a check for the scheme first.

That will be wrong.
