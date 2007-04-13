From: "Don Zickus" <dzickus@gmail.com>
Subject: Re: git-quiltimport complaining yet still working
Date: Fri, 13 Apr 2007 17:13:58 -0400
Message-ID: <68948ca0704131413t687c7196h70c6cc8c316b640e@mail.gmail.com>
References: <20070413203837.GA27660@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_11440_19372772.1176498838118"
Cc: git@vger.kernel.org
To: "Greg KH" <greg@kroah.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 23:14:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcT5p-0005A3-8W
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 23:14:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030419AbXDMVOB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 17:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbXDMVOB
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 17:14:01 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:38749 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030420AbXDMVN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 17:13:59 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1011200wxd
        for <git@vger.kernel.org>; Fri, 13 Apr 2007 14:13:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=F7y9vPK3HrwpCfPoVzeLPx+5OKzvOijKljAixuPqifsZ0Bl1edv09aTDhS8iUMMruoop3VrgpdJveCptS/JCUPLrhyXW1TeIsTbpGuDgBEGmC82b9CHnyKFv6sFUopdspe7p32TKxEj6X928vH3tGl9BkL/JuRG2BtFpCIJe+qA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=LQAbjvUCc/M0HeDTd0/KmL+t1NzMgyhPBGCOVM76N1DSlVUFrzJKV+VQDr97C1fqtlnA0S4qjATgm46j0IjwU7XLuRa1dPzS7o8CyvqHCpNkta3q5795gWQtx6W2yyOrhNjwIvhH0WzYkr7B7uAqEEkg1fy5Go8HAoaU3RLQI10=
Received: by 10.90.106.11 with SMTP id e11mr3805355agc.1176498838220;
        Fri, 13 Apr 2007 14:13:58 -0700 (PDT)
Received: by 10.90.106.4 with HTTP; Fri, 13 Apr 2007 14:13:58 -0700 (PDT)
In-Reply-To: <20070413203837.GA27660@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44431>

------=_Part_11440_19372772.1176498838118
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/13/07, Greg KH <greg@kroah.com> wrote:
> In git 1.5.1 the quiltimport function started complaining in a new way:
>
>         libata-clear-tf-before-doing-request-sense.patch
>         Patch is empty.  Was is split wrong?
>         /usr/bin/git-quiltimport: line 78: stop_here: command not found

Sorry about that.  I assumed all the scripts using git-mailinfo had
the stop_here command.  Not sure why I made that assumption.

I changed the behaviour of git-mailinfo to allow empty patches and
have the scripts check if a patch was empty and fail.  Unfortunately,
I incorrectly applied the change to git-quiltimport.

Anyway the following should fix it.

Signed-off-by: Don Zickus <dzickus@redhat.com>

------=_Part_11440_19372772.1176498838118
Content-Type: text/x-patch; name=don.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f0h4x6hx
Content-Disposition: attachment; filename="don.patch"

ZGlmZiAtLWdpdCBhL2dpdC1xdWlsdGltcG9ydC5zaCBiL2dpdC1xdWlsdGltcG9ydC5zaAppbmRl
eCBlZGNjZDgyLi4wZDIwZGM1IDEwMDc1NQotLS0gYS9naXQtcXVpbHRpbXBvcnQuc2gKKysrIGIv
Z2l0LXF1aWx0aW1wb3J0LnNoCkBAIC03NSw3ICs3NSw3IEBAIGZvciBwYXRjaF9uYW1lIGluICQo
Y2F0ICIkUVVJTFRfUEFUQ0hFUy9zZXJpZXMiIHwgZ3JlcCAtdiAnXiMnKTsgZG8KIAkoY2F0ICRR
VUlMVF9QQVRDSEVTLyRwYXRjaF9uYW1lIHwgZ2l0LW1haWxpbmZvICIkdG1wX21zZyIgIiR0bXBf
cGF0Y2giID4gIiR0bXBfaW5mbyIpIHx8IGV4aXQgMwogCXRlc3QgLXMgJGRvdGVzdC9wYXRjaCB8
fCB7CiAJCWVjaG8gIlBhdGNoIGlzIGVtcHR5LiAgV2FzIGlzIHNwbGl0IHdyb25nPyIKLQkJc3Rv
cF9oZXJlICR0aGlzCisJCWV4aXQgMwogCX0KIAogCSMgUGFyc2UgdGhlIGF1dGhvciBpbmZvcm1h
dGlvbgo=
------=_Part_11440_19372772.1176498838118--
