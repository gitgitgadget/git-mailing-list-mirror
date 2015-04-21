From: =?UTF-8?B?RGF2aWQgUm9kcsOtZ3Vleg==?= <deivid.rodriguez@gmail.com>
Subject: git's directory is _prepended_ to PATH when called with an absolute
 path
Date: Tue, 21 Apr 2015 18:37:29 -0300
Message-ID: <5536C319.4000402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 21 23:37:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkfrR-0002fQ-Pn
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 23:37:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbbDUVhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2015 17:37:37 -0400
Received: from mail-qc0-f169.google.com ([209.85.216.169]:36204 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282AbbDUVhg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 17:37:36 -0400
Received: by qcpm10 with SMTP id m10so83506077qcp.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=7tB+WECzPTb6PYpWCyvtPTraQ4pnfPS/7gMVjpbDExY=;
        b=hLO/XihRA9lRN3TTBlPX/y0ar0Lt0DfXOrqb/Q2763juQh5sZHrZCSH6DV2K/KlYup
         jP8PdGp5jiOhk4Tq6Gbgd8n3XLuGKiOQZvmlK6N+bqaSZpjBDaBVN5MBCLd0RuaTScZH
         5GU9XaeojEOE7c4R8xwN5iQu/4rst9rqcx17e7JItgtp/I9rWmpLAGrKGagMB4spdBpb
         bjsclXaWuKxuxBnsvsK5MJ63xqckDgIjCtlhIWELV1FSjiCZn0/XRViJZNf3i2Xu35CY
         h0FjCb7e41K2xvgL82oOjs6CXFExidE1Ppn7CN2j5i4Fs2vMdcVAm0nQDq7GBGl/6UJn
         KZtg==
X-Received: by 10.140.40.39 with SMTP id w36mr25238354qgw.65.1429652255981;
        Tue, 21 Apr 2015 14:37:35 -0700 (PDT)
Received: from [192.168.1.103] ([186.237.38.30])
        by mx.google.com with ESMTPSA id j81sm2248912qge.33.2015.04.21.14.37.33
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2015 14:37:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267557>

=46or example, if I run git using:

$ /usr/bin/git

then /usr/bin is prepended to the path. Is this intentional? If it is, =
why?

This causes issues with Ruby git hooks, because Ruby version managers=20
rely on custom settings in PATH to select the Ruby executable, and=20
there's usually a system Ruby living in /usr/bin. See=20
https://github.com/github/hub/issues/855 for an example.

Thanks a lot,

David Rodr=C3=ADguez.
