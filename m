From: "Patrick Doyle" <wpdster@gmail.com>
Subject: Re: git-svnexport
Date: Thu, 5 Jul 2007 09:50:27 -0400
Message-ID: <e2a1d0aa0707050650m729018f0x9e355ed23e8156af@mail.gmail.com>
References: <524f69650707031231y2ab7b9a3o7769f64b9876326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_107019_14926016.1183643427709"
Cc: git@vger.kernel.org
To: "Steve French" <smfrench@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 15:50:35 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6Rj9-0003mW-Gk
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 15:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757171AbXGENud (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 09:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757033AbXGENud
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 09:50:33 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:41352 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754894AbXGENuc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 09:50:32 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3617580wah
        for <git@vger.kernel.org>; Thu, 05 Jul 2007 06:50:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=lThAxVDZyYgGgrTDDkSQZV9QESBNjSlkonzepxnv2TQrMLf0aLWvlLDX7+bkzeKQAuPwMQA1GMr+NfTV2vxcMHf/2wDpjslRgFUCVDLi1Xk0xKnSbUHRLj6q0WZJbUiQmfddDsWO02/NvaW3PI86IIFNVDLSan5Etsl3UVyDQj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=c7xoxI//mLnryNOVUyY2l4dCrnepwQ5dxnqIQtqRdhOl2LQCvkEX8nN6b7b3uowNk4JxH/eZvfyTTjjl0zSiQoEFNcT3CM6jRjzGC9Wpu1pMIrUFMSH52UUX9cGiG73y79zEauhFWwesdkRjXYPzYhJkshv+Cfhto8ujuFuwU5E=
Received: by 10.114.121.1 with SMTP id t1mr8219070wac.1183643427746;
        Thu, 05 Jul 2007 06:50:27 -0700 (PDT)
Received: by 10.114.77.10 with HTTP; Thu, 5 Jul 2007 06:50:27 -0700 (PDT)
In-Reply-To: <524f69650707031231y2ab7b9a3o7769f64b9876326@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51676>

------=_Part_107019_14926016.1183643427709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 7/3/07, Steve French <smfrench@gmail.com> wrote:
> I noticed a git-svnexport, but don't see an easy way to do the more
> common task ... export a replica (via svn) of a kernel directory whose
> master copy is in git (no changes come through svn, all changes come
> through git).
>
> The Samba team (jra and others) use svn and would like me to keep more
> uptodate the svn branch (which I sync manually now by applying the
> patches from the kernel git tree by hand) for the two cifs git trees.
> Basically I need to do something like:
>
> git log fs/cifs
> save off each of the commits which hit fs/cifs which are not in the svn tree yet
> patch and "svn checkin" each of the commits to the svn tree
>
>
> Has anyone done any scripts to --- export -- to an svn tree from part
> of a git tree?
> I don't want to go to having my svn tree as the master and import into
> git from svn.
>
If you're interested I (may) have attached a script I was using to
learn how to import a git maintained project into a subversion
maintained project.  It is obviously a "play with this and try this
out" script, not a production script in any sense of the word, but it
might help point you in the direction you want to go.

The gist of the script is that I used .git/info/grafts to graft the
chain of git commits from my other project onto the most recent commit
from the svn maintained project (fetched via "git-svn clone") and then
I committed the result back to SVN.  All of the cruft around that is
simply, "blow away what I tried before and start from scratch all over
again" cruft I used when I was testing the concept.

hth

--wpd

------=_Part_107019_14926016.1183643427709
Content-Type: application/octet-stream; name=git-graft-test2
Content-Transfer-Encoding: base64
X-Attachment-Id: f_f3ralbug
Content-Disposition: attachment; filename="git-graft-test2"

IyEvYmluL3NoCnNldCAtZQpzZXQgLXgKCiMgQmxvdyBhd2F5IHRoZSB0ZXN0IGRpcmVjdG9yaWVz
CnJtIC1yZiBzZHJnZW4gd3BkIHNkcmdlbi5vcmlnLmdpdCBteXBhY2sKCiMgTm93IG1ha2UgZnJl
c2ggd29ya2luZyBkaXJlY3RvcmllcywgIndwZCIgaXMgdGhlIHN1YnZlcnNpb24gcmVwbywKIyAu
Li92aWRfcHJvai9zZHJnZW4gaXMgd2hlcmUgSSd2ZSBiZWVuIGRvaW5nIGFsbCBvZiBteSB3b3Jr
IHRvIGRhdGUuCmNwIC1hIHdwZC5vcmlnIHdwZApjcCAtYSAuLi92aWRfcHJvai9zZHJnZW4gc2Ry
Z2VuLm9yaWcuZ2l0CgojIEZldGNoIHRoZSBTVk4gcmVwb3NpdG9yeSBhcyBhIEdJVCByZXBvc2l0
b3J5CmdpdC1zdm4gY2xvbmUgZmlsZTovLy9ob21lL3dwZC9naXQtc3ZuLXRlc3RzL3dwZC9zZHJn
ZW4KCiMgU3RhcnQgd29ya2luZyBpbiB0aGUgbmV3IHJlcG8KY2Qgc2RyZ2VuCgojIFB1bGwgaW4g
dGhlIG9yaWdpbmFsIGdpdCByZXBvIGFzIGEgYnJhbmNoCmdpdC1mZXRjaCAuLi9zZHJnZW4ub3Jp
Zy5naXQgbWFzdGVyOm9yaWdpbmFsCkZJUlNUX0NPTU1JVD1gZ2l0LXJldi1saXN0IG9yaWdpbmFs
IHwgdGFpbCAtMWAKClRPUERJUj1gZ2l0LXJldi1wYXJzZSBtYXN0ZXJgCgojIE5vdywgZ3JhZnQg
dGhlIGZpcnN0IGNvbW1pdCBmcm9tIHRoZSBvdGhlciByZXBvc2l0b3J5IG9udG8gdGhlIGxhc3QK
IyBjb21taXQgb2YgdGhpcyByZXBvCmVjaG8gJEZJUlNUX0NPTU1JVCAkVE9QRElSID4gLmdpdC9p
bmZvL2dyYWZ0cwoKIyBDaGFuZ2UgdGhlICJtYXN0ZXIiIGJyYW5jaCB0byBwb2ludCB0byB0aGUg
aGVhZCBvZiBvdXIgbmV3bHkgaW1wb3J0ZWQKIyBjaGFpbiBvZiBjb21taXRzLgpnaXQtcmVzZXQg
LS1oYXJkIG9yaWdpbmFsCgojIFdlJ3JlIGRvbmUgd2l0aCB0aGUgb3JpZ2luYWwgYnJhbmNoIG5v
dwpnaXQtYnJhbmNoIC1kIG9yaWdpbmFsCgojIENvbW1pdCBhbGwgb2YgdGhlIGNoYW5nZXMgYmFj
ayB0byB0aGUgU1ZOIHJlcG9zaXRvcnkKZ2l0LXN2biBkY29tbWl0CgojIFdlJ3JlIGRvbmUgd2l0
aCB0aGUgZ3JhZnRzIGZpbGUgbm93CnJtIC5naXQvaW5mby9ncmFmdHMK
------=_Part_107019_14926016.1183643427709--
