From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: git failure on Solaris t3701-add-interactive.sh -- git version 5cc8f372509298d13632d8784bc851a587937550
Date: Tue, 25 Mar 2008 08:34:20 -0400
Message-ID: <8ec76080803250534x5373b0c6p6165a7dc17971e4a@mail.gmail.com>
References: <8ec76080803250529i5765cc9ar2d6fc3356800cb14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 25 13:35:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je8Mt-0004SS-EZ
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 13:35:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754202AbYCYMeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 08:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbYCYMeV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 08:34:21 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:30070 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbYCYMeV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 08:34:21 -0400
Received: by an-out-0708.google.com with SMTP id d31so808592and.103
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 05:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=slCUaxmShmhq++L2pvaMI3ogQp/dhLdpaK0to1U/i+0=;
        b=kIGyruzkTfm5KQ9ItbF7VmgiIS8dXq1P0vYdKrSKETZ+MWSJod9pjtInNO3FLP+oGE+oT/8QMKVOH0zcNqmOH9T2MRoAoN3XT1/+RBvSs1aSsYZk6m5CmnR3PZ/ANfAPX0zXVS2BTpPyNv5+g9D/jVoxXcQ87yBJzT0vu0N/K5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cIXLumu+U2WmEcPdjRiK1WajkryxNHWkHYxSIk39flRAEt0E8+pAJ7i7hAgbcvKi9hTqO5ouPafRsC9J+AXwmJqgjulnI+mwI+V9/nsmkfH/wM0mw5sKxRELMI2G0Zf6gZieQKUaaKJbSKjGsEzUxvsQR3xu6Ih7y+WWSRp+MhU=
Received: by 10.100.138.16 with SMTP id l16mr21450776and.95.1206448460280;
        Tue, 25 Mar 2008 05:34:20 -0700 (PDT)
Received: by 10.100.111.1 with HTTP; Tue, 25 Mar 2008 05:34:20 -0700 (PDT)
In-Reply-To: <8ec76080803250529i5765cc9ar2d6fc3356800cb14@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78184>

on Solaris 5.9:


xs5-trd-p1.grn:warmstro> bash t3701-add-interactive.sh -i -v
* expecting success:
        echo content >file &&
        git add file &&
        echo more >>file &&
         echo lines >>file

*   ok 1: setup (initial)

* expecting success:
        git add -i </dev/null >output &&
        grep "+1/-0 *+2/-0 file" output

Can't use an undefined value as filehandle reference at
/home/warmstro/dvl.whit/git/t/../git-add--interactive line 53.
 * FAIL 2: status works (initial)

                git add -i </dev/null >output &&
                grep "+1/-0 *+2/-0 file" output

xs5-trd-p1.grn:warmstro>


and more info from  bash -x t3701-add-interactive.sh -i -v:


++ expr ./t3701-add-interactive.sh : '.*/\(t[0-9]*\)-[^/]*$'
+ this_test=t3701
++ expr 1 + 1
+ this_test=t3701.2
+ to_skip=
+ false
+ say 'expecting success:
        git add -i </dev/null >output &&
         grep "+1/-0 *+2/-0 file" output
'
+ say_color info 'expecting success:
        git add -i </dev/null >output &&
        grep "+1/-0 *+2/-0 file" output
'
 + test -z info
+ shift
+ echo '* expecting success:
        git add -i </dev/null >output &&
        grep "+1/-0 *+2/-0 file" output
'
* expecting success:
        git add -i </dev/null >output &&
         grep "+1/-0 *+2/-0 file" output

+ test_run_ '
        git add -i </dev/null >output &&
        grep "+1/-0 *+2/-0 file" output
'
+ eval '
        git add -i </dev/null >output &&
         grep "+1/-0 *+2/-0 file" output
'
++ git add -i
Can't use an undefined value as filehandle reference at
/home/warmstro/dvl.whit/git/t/../git-add--interactive line 53.
+ eval_ret=227
 + return 0
+ '[' 0 = 0 -a 227 = 0 ']'
+ test_failure_ 'status works (initial)' '
        git add -i </dev/null >output &&
        grep "+1/-0 *+2/-0 file" output
 '
++ expr 1 + 1
+ test_count=2
++ expr 0 + 1
+ test_failure=1
+ say_color error 'FAIL 2: status works (initial)'
+ test -z error
+ shift
+ echo '* FAIL 2: status works (initial)'
 * FAIL 2: status works (initial)
+ shift
+ echo '
        git add -i </dev/null >output &&
        grep "+1/-0 *+2/-0 file" output
'
+ sed -e 's/^/  /'

                git add -i </dev/null >output &&
                 grep "+1/-0 *+2/-0 file" output

+ test t = ''
+ trap - exit
+ exit 1
xs5-trd-p1.grn:warmstro>
