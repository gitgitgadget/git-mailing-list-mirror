From: Bryan Turner <bturner@atlassian.com>
Subject: Question: git clone --no-checkout behavior
Date: Thu, 12 Jul 2012 22:51:31 +1000
Message-ID: <CAGyf7-EZOSiATo3yF5x+FT6_QAkMTJ+AmrE27kwmxLkLXdaJKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:52:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpIsR-0006S1-SL
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 14:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853Ab2GLMvd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 08:51:33 -0400
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:38730 "HELO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752313Ab2GLMvd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2012 08:51:33 -0400
Received: from mail-yw0-f47.google.com ([209.85.213.47]) (using TLSv1) by na3sys009aob121.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT/7IVJPYezRM93yLZGtWB4G9tr3N6P/h@postini.com; Thu, 12 Jul 2012 05:51:33 PDT
Received: by yhjj56 with SMTP id j56so2648511yhj.6
        for <git@vger.kernel.org>; Thu, 12 Jul 2012 05:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :x-gm-message-state;
        bh=D3WoCoQlum86GUI3nIz0Z02Gvq2o24EaerzWiEb0E/0=;
        b=FIDaYKsDXVAn74mDgq5mLTdULQpYnijYfYi2VRVdZFGmqQfAgLl9+KTAux5nV/Smz5
         sXKfCNwb+vbnwfo4p3GByMQmankqaNKAiAzCGVZ432JDQaUK9sFB6Gy7zePa/xn/OI8F
         rCeLyVbBoypMZfE3SeSaNUMJdhUZ8YcUkWfsZ/3w5vyGSPBwrWnJ9AFVKeRThdIKdtLP
         U+0y4yA7rYBtoyOKAlfbuE0cJmv6269tErnr7AxOHioLUIyUkPZ4lgJIjK8fWt3hTt3n
         hZRVsU1Vm188bGNBC19ggSXbzSHN0WmaW0+81Z7El6m2ozgfy6tHRkbMAZVKJFsfNbaa
         4Tpg==
Received: by 10.50.161.198 with SMTP id xu6mr17579558igb.40.1342097491697;
 Thu, 12 Jul 2012 05:51:31 -0700 (PDT)
Received: by 10.231.65.12 with HTTP; Thu, 12 Jul 2012 05:51:31 -0700 (PDT)
X-Gm-Message-State: ALoCoQk0K90g8sFeXaWssPX0DFNEHkiCkkv+f13yVuR3iaJxZzpQWI5lkwdeC4v60G/GwUtY+xwo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201360>

I've witnessed the following behavior in both git 1.7.6 and 1.7.10.4.

Assume I have a bare clone, some-repo.git. If I run:
- git clone --shared --no-checkout /path/to/some-repo.git shared-repo
- cd shared-repo
- git status

I see that every file in the repository is _staged_ for deletion. I'm
not surprised every file shows deleted; I'm surprised that the
deletion starts out already staged. A git reset unstages all of the
deletions and I'm good to go. I'm just wondering why they're all
staged in the first place; it seems counter-intuitive.

Can anyone shed some light on this?
Bryan Turner
