From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSOC Update] Week 6
Date: Mon, 13 Jun 2016 13:36:56 +0530
Message-ID: <20160613080656.5013-1-pranit.bauva@gmail.com>
References: <20160606065301.5228-1-pranit.bauva@gmail.com>
Cc: christian.couder@gmail.com, chriscool@tuxfamily.org,
	larsxschneider@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:08:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCMuz-0007g5-HS
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965199AbcFMIIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:08:15 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34350 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964820AbcFMIIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:08:13 -0400
Received: by mail-pa0-f67.google.com with SMTP id ug1so9998415pab.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=P+dS+L2ukdDG2Gpamk22H+bngtN0XvoYkLpSbJ1M2iY=;
        b=beQPHPS45XA/mAZs6DKEbIMoGTdONjuRWxUA+qqoV8hJhDb9hJJY6evkXOL0O8dK+f
         X7r9tuveCC5rtakifXuJSIXqI/1ZviUUBlFra7A7dTJ/x03gnFbENQZfEdFHDfmsIuoZ
         7skH1OmkHPXBGsBqqM8Ow7ZWMZfdxXpXPcEmx/q5zBU8PjXEnRvWaF1dk9+Fy98aErEd
         iBdE7z5oDqhmwJgZcWq/eLTFiGQ1Vium27zOf6rqC16k4fXAue9cwl0JBZj5NUM7gDOa
         IqE2oJ5r0+cC8Pz9PLyodHyqJXPBeHbbC6yeKHgCWpZnxOCs/027bCZEXTowLK30aLXU
         Leog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=P+dS+L2ukdDG2Gpamk22H+bngtN0XvoYkLpSbJ1M2iY=;
        b=f4Pt683mJ1eAdxdjeQZ0A1aWtREquRV5sm6t1XIAom5nw9Yw4gFYPUOGcHGgoHnnw6
         JWoltFPmO2O5+ND6l9Re2KnuKuatb3NBnavAJP9oETQIDctbcDgB3b1jC3eDqFExBFKo
         OgJxiyWOOTwmUZhst+RBtIP7VsZjaHScN/Bg7SUGC3TeDPmRghLPWI431nuP49CRhafi
         /ITQAEfUe8RUJVeVqYl0xKA1ZVOYZ8ICwB8ayenQIkaysb3fyL6J7IYmWYudyK0ZYDM5
         Wo+KcTMfyqJSYKJfseDrRsfD+v89y7iLWA8qZKbOXMcVBwzWS7zmSfK+n7a0nxTo3OpL
         s4wg==
X-Gm-Message-State: ALyK8tJ+gbIhK/a9EeLe03E7yLS7Q5nd6B2tvM/l+NXVJS3jbkQ4iUL23rE5CAlR5DYzvg==
X-Received: by 10.66.126.47 with SMTP id mv15mr20762469pab.74.1465805293029;
        Mon, 13 Jun 2016 01:08:13 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id ut6sm35288827pac.37.2016.06.13.01.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:08:12 -0700 (PDT)
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160606065301.5228-1-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297163>

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

 * bisect_clean_state() function is converted and sent out to the mailing
   list which received some useful comments from Eric Sunshine and the
   updated version can be found on bisect-reset branch[3].

 * I also converted bisect_reset() function and also introduced a file_size()
   method which received some useful comments from Eric Sunshine and Torsten
   Bogershausen. You can find the whole branch here[3].

 * I have also converted bisect_write() and will send it to the mailing list
   soon. The branch can be found here[4].

 * I also converted is_expected_rev() and check_expected_revs(). I sent
   it to the mailing list which collected some useful reviews from Eric
   Sunshine. I have updated according to the reviews. I need to confirm it
   once before I send it out on the mailing list. You can find the branch
   here[3].

 * My v2[5] on a cleanup patch to use the function macro GIT_PATH_FUNC is
   yet queued on the pu branch.

================================= NEXT STEPS ================================
Things which would be done in the coming week:

 * check_and_set_terms(): This function uses the two global variables in the
   script namely TERM_GOOD TERM_BAD. I have decided to pass then as arguments.

 * get_terms(): This will also introduce a struct to store global variables
   namely TERM_GOOD and TERM_BAD.

 * bisect_terms().

 * bisect_next_check().

[1]: https://github.com/pranitbauva1997/git
[3]: https://github.com/pranitbauva1997/git/pull/13
[4]: https://github.com/pranitbauva1997/git/pull/14
[5]: http://thread.gmane.org/gmane.comp.version-control.git/295524


Regards,
Pranit Bauva
