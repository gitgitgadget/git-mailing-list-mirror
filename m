From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: saving "git push --signed" certificate blobs
Date: Tue, 30 Dec 2014 09:39:42 +0530
Message-ID: <54A22586.70001@gmail.com>
References: <54A10ED1.9020704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 30 05:11:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y5o9F-0006Ag-Cg
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 05:11:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbaL3EJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2014 23:09:50 -0500
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63093 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbaL3EJt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2014 23:09:49 -0500
Received: by mail-pd0-f171.google.com with SMTP id y13so18522903pdi.2
        for <git@vger.kernel.org>; Mon, 29 Dec 2014 20:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=oGgceG4+mhiKWWtquJdiQLDUihC4pILmEj0Yieo1544=;
        b=PNZ8wH/Uzj3MmBG8DAU9IifhWzlT++8jhHWSLY6jumf+zltMIU6W0mDle7DDLGr59Z
         te/ayPocc7i3QMHxTl35jlCdGhnyl1i4dV9U1wZGlPs3zLXWx8i1Wre3NRM8kHmlnpFA
         /oTFy1OnqYaDqjLnFCi6CeDRSpMFdqJklL116n5O3T3XJTuytBHsRr/T/b2qmCr1/9yp
         5RSIENCrfMdAwi953jiz6i3puc9XgtAxBreQzxNV1JQME64y0Kb0kPHqMoz7pXjqtUW3
         nchc3o/2ix7xJvaro5p7pnCZaJN2LE+Zzrjgzf0322jp6MeOSttLyCP5bFc0wGCsy8xV
         uabA==
X-Received: by 10.66.55.74 with SMTP id q10mr71481972pap.94.1419912589332;
        Mon, 29 Dec 2014 20:09:49 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.165.143])
        by mx.google.com with ESMTPSA id gw8sm7570018pbc.48.2014.12.29.20.09.45
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Dec 2014 20:09:48 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54A10ED1.9020704@gmail.com>
X-Forwarded-Message-Id: <54A10ED1.9020704@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261911>

Hello,

Just wanted to say there's a little script at [1] that saves the certificate
blobs generated on the server side by "git push --signed".

Quoting from the source:

# Collects the cert blob on push and saves it, then, if a certain number of
# signed pushes have been seen, processes all the "saved" blobs in one go,
# adding them to the special ref 'refs/push-certs'.  This is done in a way
# that allows searching for all the certs pertaining to one specific branch
# (thanks to Junio Hamano for this idea plus general brainstorming).

Note that although I posted it in the gitolite ML, this has very little to do
with gitolite.  Any git server can use it, with only one very minor change [2]
needed.

sitaram

[1]: https://groups.google.com/forum/#!topic/gitolite/7cSrU6JorEY

[2]: Either set the GL_OPTIONS_GPC_PENDING environment variable by reading its
value from 'git config', or replace the only line that uses that variable, with
some other "test".
