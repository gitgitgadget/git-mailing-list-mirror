From: "Jakub Narebski" <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: No difftree output for trivial merge
Date: Fri, 21 Sep 2007 23:36:37 +0200
Message-ID: <8fe92b430709211436n562a6c47xf47da740c5cfc747@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_12858_2236887.1190410597093"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 21 23:36:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYqB3-00063X-5k
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 23:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758630AbXIUVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 17:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758294AbXIUVgi
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 17:36:38 -0400
Received: from rv-out-0910.google.com ([209.85.198.185]:51244 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbXIUVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 17:36:37 -0400
Received: by rv-out-0910.google.com with SMTP id k20so903194rvb
        for <git@vger.kernel.org>; Fri, 21 Sep 2007 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=R+wWFYxSQX/bhkNlURJkSpwsR7G3iCFUhmlYfA45g1Q=;
        b=HRng4UH7OKTuPmUkrYkB7Yp0IyGOYjQYQ+nnlyvAkrFOVBahECyt5Stlz3rlQI4nakynlLvzSFfUSKR0IT472yV9lHl3pnYZHADSDlg4s0a34dfwQkTl4KzH1RERshYsQqgwhVO8EJSo16U3FKvHzIKQGWzvnIUYGKUJLNTcDx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=DToV9zeTCCCSB1I8Gw7iY+BS198v4GMsXna6+T8CciaiPSHhmeTXerNCjGaQ3JbP9BPyhycTLfzoL5Jqoe3ov6UAEgxSNTvbfQfHtwyjjDIebWvc5qUNXhfE2M4OjHK58NdZVZw+SnSpeMshOm0AO5KVXbTzxqKUbiP93uBqu/Q=
Received: by 10.114.130.1 with SMTP id c1mr4035277wad.1190410597101;
        Fri, 21 Sep 2007 14:36:37 -0700 (PDT)
Received: by 10.114.202.19 with HTTP; Fri, 21 Sep 2007 14:36:37 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58885>

------=_Part_12858_2236887.1190410597093
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

In 'commitdiff' view, for the merge commit, there is an extra header
for the difftree table, with links to commitdiffs to individual
parents.  Do not show such header when there is nothing to show, for
trivial merges.

This means that for trivial merge you have to go to 'commit' view
to get links to diffs to each parent.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It looked a bit stupid, lone "_1_ _2_" links.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

------=_Part_12858_2236887.1190410597093
Content-Type: application/octet-stream;
 name="0002-gitweb-No-difftree-output-for-trivial-merge.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0002-gitweb-No-difftree-output-for-trivial-merge.patch"
X-Attachment-Id: f_f6v7oqez

RnJvbSBlODk1ZTViNjNhNTgwYTU0YzI0NTA5YTBkZjYzMWZmNGQzZGZmNjU4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYWt1YiBOYXJlYnNraSA8am5hcmViQGdtYWlsLmNvbT4KRGF0
ZTogU2F0LCA4IFNlcCAyMDA3IDIxOjU0OjI4ICswMjAwClN1YmplY3Q6IFtQQVRDSCAyLzVdIGdp
dHdlYjogTm8gZGlmZnRyZWUgb3V0cHV0IGZvciB0cml2aWFsIG1lcmdlCgpJbiAnY29tbWl0ZGlm
ZicgdmlldywgZm9yIHRoZSBtZXJnZSBjb21taXQsIHRoZXJlIGlzIGFuIGV4dHJhIGhlYWRlcgpm
b3IgdGhlIGRpZmZ0cmVlIHRhYmxlLCB3aXRoIGxpbmtzIHRvIGNvbW1pdGRpZmZzIHRvIGluZGl2
aWR1YWwKcGFyZW50cy4gIERvIG5vdCBzaG93IHN1Y2ggaGVhZGVyIHdoZW4gdGhlcmUgaXMgbm90
aGluZyB0byBzaG93LCBmb3IKdHJpdmlhbCBtZXJnZXMuCgpUaGlzIG1lYW5zIHRoYXQgZm9yIHRy
aXZpYWwgbWVyZ2UgeW91IGhhdmUgdG8gZ28gdG8gJ2NvbW1pdCcgdmlldwp0byBnZXQgbGlua3Mg
dG8gZGlmZnMgdG8gZWFjaCBwYXJlbnQuCgpTaWduZWQtb2ZmLWJ5OiBKYWt1YiBOYXJlYnNraSA8
am5hcmViQGdtYWlsLmNvbT4KLS0tCkl0IGxvb2tlZCBhIGJpdCBzdHVwaWQsIGxvbmUgIl8xXyBf
Ml8iIGxpbmtzLgoKIGdpdHdlYi9naXR3ZWIucGVybCB8ICAgIDIgKy0KIDEgZmlsZXMgY2hhbmdl
ZCwgMSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2dpdHdlYi9n
aXR3ZWIucGVybCBiL2dpdHdlYi9naXR3ZWIucGVybAppbmRleCBjMTgzMzlmLi4zMDY0Mjk4IDEw
MDc1NQotLS0gYS9naXR3ZWIvZ2l0d2ViLnBlcmwKKysrIGIvZ2l0d2ViL2dpdHdlYi5wZXJsCkBA
IC0yODA5LDcgKzI4MDksNyBAQCBzdWIgZ2l0X2RpZmZ0cmVlX2JvZHkgewogCSAgICAgICJkaWZm
X3RyZWVcIj5cbiI7CiAKIAkjIGhlYWRlciBvbmx5IGZvciBjb21iaW5lZCBkaWZmIGluICdjb21t
aXRkaWZmJyB2aWV3Ci0JbXkgJGhhc19oZWFkZXIgPSBAcGFyZW50cyA+IDEgJiYgJGFjdGlvbiBl
cSAnY29tbWl0ZGlmZic7CisJbXkgJGhhc19oZWFkZXIgPSBAJGRpZmZ0cmVlICYmIEBwYXJlbnRz
ID4gMSAmJiAkYWN0aW9uIGVxICdjb21taXRkaWZmJzsKIAlpZiAoJGhhc19oZWFkZXIpIHsKIAkJ
IyB0YWJsZSBoZWFkZXIKIAkJcHJpbnQgIjx0aGVhZD48dHI+XG4iIC4KLS0gCjEuNS4zCgo=
------=_Part_12858_2236887.1190410597093--
