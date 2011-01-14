From: Johan Herland <johan@herland.net>
Subject: Re: How does 'git notes --ref' work?
Date: Fri, 14 Jan 2011 11:49:38 +0100
Message-ID: <201101141149.38778.johan@herland.net>
References: <AANLkTimL137aFt2dyvdHxTMUjB4diwJQG-FQiYEK8tVJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Edwin Kempin <edwin.kempin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 11:53:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdhHk-0001y0-Do
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 11:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab1ANKtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 05:49:43 -0500
Received: from smtp.opera.com ([213.236.208.81]:45296 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab1ANKtm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 05:49:42 -0500
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p0EAncop003873
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 14 Jan 2011 10:49:39 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <AANLkTimL137aFt2dyvdHxTMUjB4diwJQG-FQiYEK8tVJ@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165091>

On Friday 14 January 2011, Edwin Kempin wrote:
> How does 'git notes --ref' work? If I try
> 'git notes --ref refs/meta/reject-commits add -m "reject" HEAD'
> then the note is added to 'refs/notes/refs/meta/reject-commits' and
> not as expected to 'refs/meta/reject-commits'.
>
> The description of the --ref option says [1]:
> "The ref is taken to be in refs/notes/ if it is not qualified."
> What is a qualified ref?

A qualified ref (in this context) is one that starts with refs/notes. If 
it doesn't start with refs/notes, then refs/notes is prepended to it.

This is a restriction we put in place to make sure the notes 
infrastructure didn't edit (i.e. damage) any refs outside the 
refs/notes/ namespace.

We will probably remove this restriction in a future Git version. Until 
then, please keep your notes within the refs/notes/ namespace.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
