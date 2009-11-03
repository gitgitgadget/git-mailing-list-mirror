From: Adam Mercer <ramercer@gmail.com>
Subject: determine if the tree is dirty
Date: Tue, 3 Nov 2009 12:57:37 -0600
Message-ID: <799406d60911031057l5dcb4d4fi3705cc66997ff7f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 19:58:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5Oa8-00065h-RU
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 19:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752970AbZKCS5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2009 13:57:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752892AbZKCS5y
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 13:57:54 -0500
Received: from mail-qy0-f174.google.com ([209.85.221.174]:52576 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbZKCS5w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2009 13:57:52 -0500
Received: by qyk4 with SMTP id 4so3077764qyk.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 10:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=/OmselmdF3NmpbJ//FR92EGBbLI5ATJ9ShAYZk87GtY=;
        b=naesYkp77KB3tBrI6eVHNToc1hYbo2ukBhUy7ZQ5PFvHb4wT3G3CJe+IkhaIEY3E0N
         sr7qI4f8Z/ZdMAgfwYkiW30duqIaTsCkkIeAq6YKQpIRVztE4sacu3kFw3qQpoCPumgd
         XxX76515HkA983+ZKggoiWP/9X2ZuyuX3jqdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=v9fUcl8l1rPxJpD6oXxWhQtWOp9CUmFEn5a+ohjiY8u1EtvXRjrVRntLi8dDXBjVAa
         YfaQCuxGl6tpCeiBj4VL5wGatK1g0EMMxR0ONLFe5HpWvLTu2/UyX05cKWMSqtk1MgQd
         FDixAFQT+Q2qrkCnajzSHBvKifjvdL3sGi15o=
Received: by 10.229.111.195 with SMTP id t3mr55907qcp.44.1257274677229; Tue, 
	03 Nov 2009 10:57:57 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131987>

Hi

As part of a python script I need to determine if a tree has any
uncommitted changes, so far I am been using:

  # determine tree status
  status_cmd = 'git status'
  status_output = run_external_command(status_cmd,
honour_ret_code=False)[1].strip()
  if status_output.endswith('no changes added to commit (use "git add"
and/or "git commit -a")'):
    git_status = 'UNCLEAN: Some modifications not committed'
  else:
    git_status = 'CLEAN: All modifications committed'

but I feel that this relies to heavily on the porcelain and that there
should be a better way to accomplish this without relying on parsing
the output of git-status.

Does anyone know of a better way to accomplish this?

Cheers

Adam
