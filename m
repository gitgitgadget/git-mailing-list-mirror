From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 5
Date: Mon,  6 Jun 2016 12:23:01 +0530
Message-ID: <20160606065301.5228-1-pranit.bauva@gmail.com>
References: <20160530053758.28134-1-pranit.bauva@gmail.com>
Cc: larsxschneider@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 08:56:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9oSD-0002uI-3M
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 08:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbcFFGz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 02:55:56 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33597 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbcFFGzz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 02:55:55 -0400
Received: by mail-pa0-f67.google.com with SMTP id di3so11163907pab.0
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 23:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hw5fBr8p35Wt8g5QIlTMwmUFnDXsF3DOuVbtEEx60As=;
        b=HbSB8C/tWxkghiQ7LSCiZPKY+e9436Il1Tkkj8f4V6okjpKAsAzhWO7YtO+wokVxs1
         YYydEIx6u4/VCyCtIJCXFw0JhpkAlYob5H2/TOHHvSX0HNBdnFyhBEap31Lnm6lHqjd8
         FypJ4ndW6SkR1JTAnjomQi1J7l4Kn3fNFUVecJ/l/9ZDM9w0Kj3WZWGAqpSIG3ATuOyx
         3lzXprB9gDr2ULKAxbWvDrg50/20ODuk65YNuKPGtYUCgS4gTLtsqphl2rNK1n4uM9Ul
         3oZ1bhpXVAU7ZuK4lW+ZYarmp9Jk+qXchRgXXcF+xuDA6K9AwUvgnJyU1/W5/Kzr6tWy
         Jnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hw5fBr8p35Wt8g5QIlTMwmUFnDXsF3DOuVbtEEx60As=;
        b=ZBoLkQvk2bxv+anyIzbX05Poc8BC7fX1hfP3E/mo51zVv1ejZWRX9maEcwR5bn7AvV
         5YyKvs/1gRCe08z8maGSjy09vf+9g4HKDCU5qQ6ymvYkJuxyFXLJFRg6T2+1ESMs6wcp
         ZRLVlbJU04PsmpqfAF+wcUGyQaYa8dsORjOgKJ7M2yW3cSX1Ap+bimWd3FC3rLePcpdD
         c3VA4ukzkgU4YwWUNZRODY33UZNbCZYbEV/gN5nnLp6Ou1fFeRNl/M74K/3cLcrf9G1a
         9CWFvlZUWABtaZ3YOeowpiuEkF1cAQXO5CamPk1ZRRMFWo1dnR415VGSi+7QATcb1/O3
         nGuw==
X-Gm-Message-State: ALyK8tI61yfMhMYTbLjF6qtrFT1mtwdGQ1xoihsz6sgFhFDplKVMxg5NTjnh+9gJsCw3tA==
X-Received: by 10.66.152.111 with SMTP id ux15mr22892390pab.43.1465196154995;
        Sun, 05 Jun 2016 23:55:54 -0700 (PDT)
Received: from localhost.localdomain ([183.87.140.254])
        by smtp.gmail.com with ESMTPSA id g13sm24744287pfk.2.2016.06.05.23.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jun 2016 23:55:54 -0700 (PDT)
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160530053758.28134-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296484>

================================= SUMMARY ==================================
My public git.git is available here[1]. I regularly keep pushing my work so
anyone interested can track me there. Feel free to participate in the
discussions going on PRs with my mentors. Your comments are valuable.


=============================== INTRODUCTION  ==============================
The purpose of this project is to convert the git-bisect utility which partly
exists in the form of shell scripts to C code so as to make it more portable.
I plan to do this by converting each function to C and then calling it from
git-bisect.sh so as to use the existing test suite to test the function which
is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>


================================== Updates =================================
Things which were done in this week:

 * bisect_clean_state() function is converted and I have fixed the
   segmentation fault. I am now polishing the patch with the help of my
   mentors and will soon send it to the mailing list. The seg fault occurred
   because I was deleting the refs in the for_each_ref_in() iteration. On
   sending the RFC[2], Michael Haggerty pointed out the fact that deleting refs
   causes some malfunction with the ref cache and thus triggering the seg
   fault.

 * I also converted bisect_write() function and currently I am polishing it
   with the help of my mentors and will send it to the mailing list. You can
   find the whole branch here[3].

 * As a preparatory patch for bisect_write() I also introduced a function
   file_size() which will get the file size without actually opening the
   file.

 * I also converted is_expected_rev() and check_expected_revs() and also fixed
   the segmentation fault. I am now polishing the patch with the help of my
   mentors and will soon send it to the mailing list. You can find the branch
   here[4].

 * My v2[5] on a cleanup patch to use the function macro GIT_PATH_FUNC is
   yet to receive comments.

 * I have also converted bisect_head()[6] but that would be sent to the mailing
   list along with bisect_state().

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * Convert the function bisect_write(). I plan to convert this function and
   add it as a subcommand.

 * Convert get_terms() and add the variables TERM_GOOD and TERM_BAD in a struct
   in the global state.

 * Convert bisect_voc()

 * Convert bisect_next_check()

[1]: https://github.com/pranitbauva1997/git
[2]: http://thread.gmane.org/gmane.comp.version-control.git/295917
[3]: https://github.com/pranitbauva1997/git/pull/13
[4]: https://github.com/pranitbauva1997/git/pull/10
[5]: http://thread.gmane.org/gmane.comp.version-control.git/295524
[6]: https://github.com/pranitbauva1997/git/pull/11


Regards,
Pranit Bauva
