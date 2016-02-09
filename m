From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Tue, 9 Feb 2016 10:46:04 -0800
Message-ID: <CAGZ79kb=rkRnP1SnMLtyNkn8DeCAtqoDriYc7051u-Z9isKZoQ@mail.gmail.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
	<20160208122551.GD24217@sigill.intra.peff.net>
	<9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
	<xmqq4mdh4tel.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
	linux.mdb@gmail.com, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:46:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTDIy-00080v-Pw
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 19:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbcBISqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 13:46:07 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37679 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374AbcBISqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 13:46:05 -0500
Received: by mail-ig0-f175.google.com with SMTP id 5so18361186igt.0
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 10:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dFSu0lFC2oykNuP0jv1p4FXq4SJ64vKGb6Cen9M1K8w=;
        b=LaSv9NQxeI9hyC9+0Yvk2zqKBjz0kOxqK9udObk5Kmivl2J25FkwTiwSvP7f3r8ifY
         /x2DTeNXxFDEl1X4XwvUP+QNb/ZSFIU6xJ2RIITudxcREUbFNEAMF/DgCqU60FOFvUet
         67PAOFhSh3Vhx17RnOygBQUGsNWYLlxznEXGRHQ+rpXhUZ3B5ejyXEhs/4xCPY/RSA8p
         BvpWQjg2IPPAeoALyj781JExyKz7UtUQIPdcgqmEN6YXyjvojsCndqTJDmiUVR9zmzBU
         dKyIgHbuMBNjzYvYEmHWQa0dQj854yRrTO/NvRFv01bAL+oTveMV2F7je8naize+0XMm
         8SMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dFSu0lFC2oykNuP0jv1p4FXq4SJ64vKGb6Cen9M1K8w=;
        b=iaq/O3GV/5Bnvqsl5xkLd/kc9KK6i5wkKa85v8MMM2wU2cN6K9xKWrq1bUMOEWt/FD
         oaY5RxJ3scKP/WadASXJVvNYNHN7MNaDyIm7Fc5/71+STOrJSGtqNFnMaTZRU681nQKs
         fM7R1IjNHOFdMk5/PkPKshHssinLGFHWJk+aoYAbjTJke5qeKpWd9kUo8bY2eVPrU33m
         cSWU663Dnl23NwqaZWIm7DVFQKo0jDGvyppHnWmKKmBZgv5dg/NdmWc3qhiIGaE//Ziu
         jy3eK0N96q00nIKmT20OHTKsCDF79/8PpiRYPUA8nqaxAf7S/AXXzEiDtLLnW1shOzRk
         1KhA==
X-Gm-Message-State: AG10YOQk9WzzSMvqtdIp8G1rx34lJp410tur+NLaqRd/tzLcjJQqXk+mP5Xd4vAZhzzcwCKVgly0rmkFJMgYXwfr
X-Received: by 10.50.80.14 with SMTP id n14mr6027300igx.85.1455043564212; Tue,
 09 Feb 2016 10:46:04 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 9 Feb 2016 10:46:04 -0800 (PST)
In-Reply-To: <xmqq4mdh4tel.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285850>

On Tue, Feb 9, 2016 at 10:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> Jeff Merkey made me aware of http://kernelnewbies.org/FirstKernelPatch [2]
>> where I found checkpatch.pl [3]. Would it make sense to check all commits
>> that are not in next/master/maint with this script on Travis-CI?
>
> That does not help very much.  These changes are already shown to
> people and dirtied their eyes, and most likely I've already have
> wasted time tweaking the glitches out locally.  The damage has
> already been done.
>
> It would make a lot of sense if the checkpatch is called inside
> Roberto Tyley's "pull-request-to-patch-submission" thing, though.

Last time I reported a bug/feature request, Roberto was glad to be
cc'd as he doesn't read the mailing list in full. So I cc'd him here.
