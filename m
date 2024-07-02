Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE201BA06C
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 14:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719929631; cv=none; b=diKsXogNcQk70k17G7EVMCNmPPYBK7UXS6BX4SszuWhzMDDqRXOH9lSZv5H5y3t5UoWV1L5r3O1xTxe+ZUhNtr5/plSUxVRpeLAz8ZhRGROl9lN1Rq9tpcN/Z4FxYSt3V1JiATRpmZUeDDYSrh/8mcEIdDgeHi5nA5R3q9O9pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719929631; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:Cc:To; b=IQG8dTkJJappSqVfY5iJTTXBh9mAGuYXEJLWT5gkVWkfiuODRtIdzF3EHN3bMhOKUFpsA1O3lRjacnZaPggYZfYARWrREEFGo0tUryNAV8cR018fkF3k/z7hYh6VCmYsLZW9fz6oRF/+caEZTiP5kH0fGfA832dZS//mfWVVRhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8iC/cLc; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8iC/cLc"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-64789495923so37408137b3.0
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 07:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719929629; x=1720534429; darn=vger.kernel.org;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=V8iC/cLcX3x/7TfWcxmgHgaNDqXYxo9sxqJ+npeS8QhMddbdsik3kUsrzj+YybrrXT
         7FStT2tLvv/n+sbTmQ12tBRqE9aM7bA/UcV1T6DSd8udYD3n2PYGcT27pJbSxr6Vozpp
         PhZOvzcVso9Xz7OT83fVfsRogSjdioOXipqf+7OlzR8gg3vkYPKMV9tP1uhU9xMRm4Cd
         AEH/iCOB9IjhGaS7wpz8CakyMHyitWfImmmoo1pG0ozmn/arT0d9J963rrPffOEtd9sI
         X4DdQv/+PEjcpYfVjxVlywJw/p2RGANQaSzeynLZgp3nWkC8t3NGFVRGnnTzPrxY4Gab
         NCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719929629; x=1720534429;
        h=to:cc:message-id:subject:date:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
        b=iBVSjCCJ1RmlAiq7T+bxoVX0hx0BnD8gTnFO4oHUrZVokF/fM3v/Daxr6zANjxgcdi
         6p83R7EZDZy6cVUAyKuBIkmlI7vt16qgQS1aqmfhgq9xCAQjaDxUdySPpCqz2u3/0oWO
         d3LP5zxCaIYi9QUfB7S5DxZFhDUTW6hasCeW5ETgw5PNsgONCTCHJFDLnp+4/EEaevMX
         SAYE6AUQjo+EdDqWF8pFBIMu/BWIgaD84NXihOIaqvsBjYz4BeU1dsUUEgwqt9p/KWeI
         eVOHSaUaagOd3IEjRiqfy/pAbvGCwcuelsbornKjJ8i0oemu4wb4YPaue6MGxz4gQznF
         chHA==
X-Gm-Message-State: AOJu0YzDdbYS4siMYwdMU0popOg/8LSRj5IBkYpnjMS+otHTa79J2Rr5
	4MV9d3PmmeOOe5y0DzaC523VJnMFtQkVf9/5JT3xyHBZmdH/7FAhfrU1tg==
X-Google-Smtp-Source: AGHT+IG7cZqqqcdOM/F1loasELlLBVstRav1qGpUqZg0rLI3734FOsEoyQOGknWiagHbAGdrHNg+OA==
X-Received: by 2002:a81:f003:0:b0:64b:392a:b9d7 with SMTP id 00721157ae682-64c739e2964mr87457317b3.45.1719929629175;
        Tue, 02 Jul 2024 07:13:49 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:8f50:4030:2c7f:753d:4dae:4029])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65055384cd8sm1814347b3.39.2024.07.02.07.13.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 07:13:49 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Kenneth Porter <klowflynno36@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 2 Jul 2024 10:13:37 -0400
Subject: Re: A few usability question about git diff --cached
Message-Id: <87E0708F-7AB7-4D3C-84ED-2EAD09CD3E8B@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, paolo.ciarrocchi@gmail.com,
 vmiklos@frugalware.org
To: m.mahmeed911@icloud.com
X-Mailer: iPhone Mail (21F90)


Sent from my iPhone
