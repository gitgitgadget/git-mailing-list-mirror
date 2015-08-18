From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/7] Submodule improvements
Date: Mon, 17 Aug 2015 17:38:05 -0700
Message-ID: <CAGZ79kYqCLQYt7Aosr57rkfHhqVVttuoWGwT4n-Nx7jU0+L2_A@mail.gmail.com>
References: <1439857323-21048-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Stefan Beller <sbeller@google.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:38:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUuq-0006qy-NM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbbHRAiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:38:08 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:32856 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102AbbHRAiG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:38:06 -0400
Received: by ykll84 with SMTP id l84so79969306ykl.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0x7+8bkX26MDu7dMrQXp2wzdGhKPxXoNcW4MXs5ooFc=;
        b=F8AdxcoQfIWldLXsvERFGV+W2/hPXDPyfH+TbH1Ih9x6VCMF0I/sZZp+W0/HKFVzoR
         OU8AI6gjly4oyaTrFmGQaQVAvtHzukprmlkdLPJKDYpBoJxJm0ni2CpNm4t9qtnMy5Mf
         rW5CitqChLmcDirVzgoXsS1tXzdaQNEzXmOG50smeNzIzENDXyjo+nvZH2uXhTSCwd6N
         lGmTF3ILDOOv84FG48zV7G0SlRkRN5MXjiXu0SV4pbJfB6QKs9TNwym/ieynSnj0+DCS
         SUlzrCq4jMT2MRed0sFo9b/5B7W0s1ryNg1jptdD6pFTLvvjJGVwpGDwydUC/ldXGpj+
         YNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0x7+8bkX26MDu7dMrQXp2wzdGhKPxXoNcW4MXs5ooFc=;
        b=TAh1EgfuLBU60X1x64MMI0S3UzReWzidb9diLTJPzWUS1SemJ+M1ABjv/SB8ku3mp0
         HtytkyIg9jakElxgHUawqt4/HaDtsKw+VfWXcpdwpKdDoqEqGwtkWXJYt+p2qlqnoGyv
         LA+sknSGk6VxcIECkgTNbfwkHsf2e2mn+mbjR0v8k6ts7JjprWnoyiH1h6Pb1LM07lYp
         SA+jVPgRzqb29JBxg5c7RjzLI08Wz6cPXVPSR+HkjGKaI/nSd25Ar3bhcpmLhnKWU15b
         ieosbqsUCQabyxDaV/OlJoWwateoQD+8YJafMlegHT798XU5z485Don5I+sIUjYUXZCi
         2tQA==
X-Gm-Message-State: ALoCoQmW+YYXvWjNezO0eolk/vkfbKhGAE+K/0a+T78pvYbutmS5+5mJ7qTPpI+eD023JtQdiU8U
X-Received: by 10.170.56.8 with SMTP id 8mr4442291yky.115.1439858285438; Mon,
 17 Aug 2015 17:38:05 -0700 (PDT)
Received: by 10.37.21.129 with HTTP; Mon, 17 Aug 2015 17:38:05 -0700 (PDT)
In-Reply-To: <1439857323-21048-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276119>

A last minute change in the last patch broke t7400-submodule-basic.sh, test 82
