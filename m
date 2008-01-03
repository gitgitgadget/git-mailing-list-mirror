From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [RFH] On a script for submodules
Date: Thu, 3 Jan 2008 15:52:04 +0600
Message-ID: <7bfdc29a0801030152t25de6889wc21b9c933f5b9ab9@mail.gmail.com>
References: <7bfdc29a0801030107t54ca45dbq167666b337f59a01@mail.gmail.com>
	 <7vsl1fs0xa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_14779_5751244.1199353924103"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 03 10:52:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAMkk-0008G4-Bf
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 10:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYACJwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 04:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYACJwK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 04:52:10 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:17823 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbYACJwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 04:52:08 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6573642fkz.5
        for <git@vger.kernel.org>; Thu, 03 Jan 2008 01:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        bh=E4kcoKTaZpKNv92gIbjUxvQewzYpo5MPSiTbp9VVmyo=;
        b=FD+9po9+/D7WcYqFqhz8Kfi8cgqWJF4mJP2R24KarWhfjJ8ZkFV2ssY2oWjCGL9I/ShnaW38pdh9PW+aikRB0rY21/As5g1pgJWKoHUELMWLIJfbR4ob3Ij7vnz5OwjN2CQHf5tIGuiVvpN+9mA3Wrvz0HzR8pA/NI4ITK+RHCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:references;
        b=T8nc4LWn4pIBOHbChTXHCmTlIISe90T4GrZ7K3SxLV2xzR832fcNKDsfwkiLMMzLLlkMIKT4M8hhFh/EwmTUuDvN7yi0CQ0stgagPlHerSEU2ex2BbppJNhUg4LuK2ELlDzWK/yGM7m5xx8LTwzS/e9ql1L1Tx+kc8W+PSVayMQ=
Received: by 10.78.172.20 with SMTP id u20mr17765970hue.3.1199353924117;
        Thu, 03 Jan 2008 01:52:04 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Thu, 3 Jan 2008 01:52:04 -0800 (PST)
In-Reply-To: <7vsl1fs0xa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69521>

------=_Part_14779_5751244.1199353924103
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all,

Sorry for referring to the blog. I am writing the details here again
and also attached the script in the email.

I am fairly a new git user; I started working around with GIT on
Framework development project and I noticed that GIT commands executed
on the parent module is not propagated to the child modules. In some
use cases it would be extremely useful (at least for me) to be able to
be propagate a command from the master module to all its child at all
depth. I wrote the bash shell script (in the attachment) to simply
propagate commands from parent to its child. To use this script one
can simply do the following (I am assuming that the file will have the
name git-modules and will be an executable in $PATH):

    for: git-pull
    do: git-modules pull

    for: git-status
    do: git-modules status

    for: git-commit -a -m "This is a test commit"
    do: git-modules commit -a -m "This is a test commit"

    for: git-checkout master
    do: git-modules checkout master

Basically any git-X command can be simply be done as "git-modules X
args-as-usual".

It is mainly different from the git-submodule command in its usage. I
mainly wrote it to propagate commands. It could be extended for
further usage as well.

I would really appreciate and welcome criticism, feedback and addition
to the script.

Thank you,

On Jan 3, 2008 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "Imran M Yousuf" <imyousuf@gmail.com> writes:
>
> > ... I would really appreciate if someone would take their time to
> > suggest me improvements. I would also like to get some feedbacks as
> > what else could be added here. A brief description can be found in the
> > following posting.
>
> Around here, it is customary to have discussion on-list, not
> pointing at external web pages and repositories.  I would
> suggest starting by stating what the overall design is and how
> it meshes with existing git-submodule command and its design.
>
>
>



-- 
Imran M Yousuf

------=_Part_14779_5751244.1199353924103
Content-Type: application/octet-stream; name=git-modules
Content-Transfer-Encoding: base64
X-Attachment-Id: f_faz42giu0
Content-Disposition: attachment; filename=git-modules

IyEvYmluL2Jhc2gKCkFSR1M9MQppZiBbICQjIC1sdCAiJEFSR1MiIF07IHRoZW4KCWVjaG8gTm90
IGVub3VnaCBhcmd1bWVudHMuCgllY2hvIEV4YW1wbGUgXCJcPHRoaXMgc2NyaXB0XD4gc3RhdHVz
XCIgZm9yIFwiZ2l0LXN0YXR1c1wiIC0gZ2l0LW1vZHVsZXMgc3RhdHVzCglleGl0IDY1OwpmaQoK
ZnVuY3Rpb24gdHJhdmVyc2VNb2R1bGUoKSB7CgljdXJyZW50X2Rpcj1gcHdkYAoJZGlyX3BhdGg9
IiRjdXJyZW50X2RpcjokZGlyX3BhdGgiCiAgICAgICAgY2QgJDEKICAgICAgICBldmFsICQyCglp
ZiBbIC1mIC5naXRtb2R1bGVzIF07IHRoZW4KICAgICAgICAgICAgICAgIGZvciBtb2RfcGF0aCBp
biBgZ3JlcCAicGF0aCA9IiAuZ2l0bW9kdWxlcyB8IGF3ayAne3ByaW50ICQzfSdgOyBkbwogICAg
ICAgICAgICAgICAgICAgICAgICB0cmF2ZXJzZU1vZHVsZSAkbW9kX3BhdGggJDIKICAgICAgICAg
ICAgICAgIGRvbmUKICAgICAgICBmaQoJb2xkX2Rpcj0kKGVjaG8gJGRpcl9wYXRoIHwgY3V0IC1k
JzonIC1mMS0xKQogICAgICAgIGNkICRvbGRfZGlyCglkaXJfcGF0aD0ke2Rpcl9wYXRoOiQoZWNo
byAiJHsjb2xkX2Rpcn0rMSIgfCBiYyl9Cn0KCnByb2plY3RfaG9tZT1gcHdkYAplY2hvIFByb2pl
Y3QgSG9tZTogJHByb2plY3RfaG9tZQppZiBbIC1kICRwcm9qZWN0X2hvbWUvLmdpdC8gXTsgdGhl
bgoJZ2l0X2NvbW1hbmQ9JDEKCXNoaWZ0Cgljb21tYW5kX2FyZ3VtZW50cz0iIgoJZm9yIGFyZyBp
biAiJEAiOyBkbwoJCWlmIFsgYGV4cHIgaW5kZXggIiRhcmciICcgJ2AgLWd0IDAgXTsgdGhlbgoJ
CQlhcmc9IlwiJGFyZ1wiIgoJCWZpIAoJCWNvbW1hbmRfYXJndW1lbnRzPSIkY29tbWFuZF9hcmd1
bWVudHMgJGFyZyIKCWRvbmUKCWVjaG8gR0lUIENvbW1hbmQgZ2l0LSRnaXRfY29tbWFuZCB3aXRo
IGFyZ3VtZW50c1woJCNcKSAiJGNvbW1hbmRfYXJndW1lbnRzIgoJbWFpbl9jb21tYW5kPSJnaXQt
JGdpdF9jb21tYW5kICRjb21tYW5kX2FyZ3VtZW50cyIKCWV2YWwgJG1haW5fY29tbWFuZAoJaWYg
WyAtZiAuZ2l0bW9kdWxlcyBdOyB0aGVuCgkJZm9yIG1vZF9wYXRoIGluIGBncmVwICJwYXRoID0i
IC5naXRtb2R1bGVzIHwgYXdrICd7cHJpbnQgJDN9J2A7IGRvCgkJCXRyYXZlcnNlTW9kdWxlICRt
b2RfcGF0aCAiJG1haW5fY29tbWFuZCIKCQlkb25lCglmaQplbHNlCgllY2hvICRwcm9qZWN0X2hv
bWUgbm90IGEgZ2l0IHJlcG8gdGh1cyBleGl0aW5nCglleGl0CmZpCgo=
------=_Part_14779_5751244.1199353924103--
